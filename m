Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289698AbSAOWRO>; Tue, 15 Jan 2002 17:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289702AbSAOWRE>; Tue, 15 Jan 2002 17:17:04 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52719 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289698AbSAOWQ6>;
	Tue, 15 Jan 2002 17:16:58 -0500
Date: Tue, 15 Jan 2002 15:16:29 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: Why not "attach" patches?
Message-ID: <20020115151629.N11251@lynx.adilger.int>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201151448050.5892-100000@xanadu.home> <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org>; from mochel@osdl.org on Tue, Jan 15, 2002 at 02:09:27PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 15, 2002  14:09 -0800, Patrick Mochel wrote:
> On Tue, 15 Jan 2002, Nicolas Pitre wrote:
> > Pine always worked fine when patches are imported with ^R.
> 
> It doesn't at all. It silently removes extra white space at the end of
> lines. It's been a "feature" since about 4.30 or so.
> 
> Does anyone recall exactly which version this changed in? Or, have any of
> the vendors reversed this wart?

Well, it would be a feature if it knew enough to only remove whitespace
at the end of "+" lines in context diffs.  Then we wouldn't have 200kB
of useless whitespace in the kernel sources.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

