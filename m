Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJ2TLJ>; Tue, 29 Oct 2002 14:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJ2TLJ>; Tue, 29 Oct 2002 14:11:09 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:39928 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262122AbSJ2TLI>; Tue, 29 Oct 2002 14:11:08 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 29 Oct 2002 12:14:53 -0700
To: David Fries <dfries@mail.win.org>
Cc: Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 dies without inodes
Message-ID: <20021029191453.GL28982@clusterfs.com>
Mail-Followup-To: David Fries <dfries@mail.win.org>,
	Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
References: <200209261355.g8QDtRg16986@sisko.scot.redhat.com> <20021029190029.GA27062@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029190029.GA27062@spacedout.fries.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2002  13:00 -0600, David Fries wrote:
> I'm runnig 2.4.19 and Debian (but I compile my own kernel from the
> sources).  ext3 is forcing the block device to be read only when I run
> out of inodes, and the only way out is reboot (that I could tell).
> This is wrose than a good deal of kernel panics I've had.  Is
> 2.4.20prewhatever any better with reguard to this error?

Yes, this is fixed in more recent kernels.  Separate patches are also
available if you want to stick with 2.4.19 for whatever reason.
Stephen posted a URL for them a couple of times.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

