Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287013AbRL1UgK>; Fri, 28 Dec 2001 15:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287011AbRL1Ufz>; Fri, 28 Dec 2001 15:35:55 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:15356 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287008AbRL1Ufo>;
	Fri, 28 Dec 2001 15:35:44 -0500
Date: Fri, 28 Dec 2001 13:34:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Riley Williams <rhw@memalpha.cx>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011228133459.Y12868@lynx.no>
Mail-Followup-To: Riley Williams <rhw@memalpha.cx>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011227163130.N12868@lynx.no> <Pine.LNX.4.21.0112281810330.3044-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0112281810330.3044-100000@Consulate.UFP.CX>; from rhw@memalpha.cx on Fri, Dec 28, 2001 at 06:34:16PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28, 2001  18:34 +0000, Riley Williams wrote:
> Can I suggest an alternative: Retain the MAINTAINERS file as it
> currently is, but add a PATCHES-TO file in each subdirectory that
> states how to handle patches relating to that directory, and have
> these files follow a strict format, possibly...
> 
> ===8<=== CUT ===>8===
> 
> HomeDir = linux/subsystem/
> List = subsystem@server.site
> Maintainer = Guess Who <uessWho@hear.thou.me>
> Watch * = Interested <interested@private.site>
> Watch PATCHES-TO = John Doa <administrator@linux.org>
> 
> ===8<=== CUT ===>8===
> 	WATCH filespec = name <email-address>
> 
> 		Specifies that the email address specified is also
> 		interested in patches relating to the specified
> 		files, and should be CC'd patches relating to just
> 		the files specified. Files of interest are selected
> 		using ls style wildcards. Can be repeated as often
> 		as required for either the same or different files.
> 		The filespec can not contain / characters, and only
> 		matches files in the current directory.

I'd rather just skip the WATCH part entirely (or limit it to people already
in the MAINTAINERS list).  If someone is interested in part of the code,
they can subscribe to the mailing list.

Also, if the PATCHES-TO file already lives in a particular subdirectory,
I don't see the benefit of HomeDir, except to increase the maintenance
work.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

