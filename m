Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292628AbSB0RwV>; Wed, 27 Feb 2002 12:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSB0RwL>; Wed, 27 Feb 2002 12:52:11 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:27895 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292839AbSB0Rvu>;
	Wed, 27 Feb 2002 12:51:50 -0500
Date: Wed, 27 Feb 2002 10:51:32 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Getting incorrect size on large files from DVD
Message-ID: <20020227105132.Q12832@lynx.adilger.int>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020226100029.G12832@lynx.adilger.int> <Pine.LNX.4.30.0202271336020.11913-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0202271336020.11913-100000@mustard.heime.net>; from roy@karlsbakk.net on Wed, Feb 27, 2002 at 01:36:36PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 27, 2002  13:36 +0100, Roy Sigurd Karlsbakk wrote:
> > Are you mounting it as UDF or as ISO?  You should use UDF for DVD discs.
> 
> is UDF backwards compatible with ISO, or should I mount CDROMs
> specifically as ISO?

Sorry, I don't know for sure.  You could always try mounting them as ISO.
What I did in the end was to have two symlinks (/dev/cdrom and /dev/dvd)
pointing to the same device (/dev/hdc) and then in /etc/fstab put in a
different fs type for each device.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

