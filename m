Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSBMQaH>; Wed, 13 Feb 2002 11:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbSBMQ3z>; Wed, 13 Feb 2002 11:29:55 -0500
Received: from [63.231.122.81] ([63.231.122.81]:14942 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S287596AbSBMQ3k>;
	Wed, 13 Feb 2002 11:29:40 -0500
Date: Wed, 13 Feb 2002 09:29:08 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Faux Pas III <fauxpas@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 Oops, maybe LVM ?
Message-ID: <20020213092908.D25535@lynx.turbolabs.com>
Mail-Followup-To: Faux Pas III <fauxpas@temp123.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020213063548.GA463@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020213063548.GA463@temp123.org>; from fauxpas@temp123.org on Wed, Feb 13, 2002 at 01:35:48AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  01:35 -0500, Faux Pas III wrote:
> I'm getting reproducible oopses whenever I pull a file over the network
> off of my LVM filesystem, so not exactly sure where this is coming
> from...  this happens with vanilla 2.4.17 although the kernel that I 
> captured the oops output from has LVM 1.0.2 and posix acls patches on
> it.
> 
> Raw oops text and ksymoops output are at http://www.burdell.org/~fauxpas/

This appears to be an oops in ext3/jbd and has nothing to do with LVM
as far as I can see.  Please post the decoded oops to ext3-users@redhat.com
or ext2-devel@lists.sourceforge.net.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

