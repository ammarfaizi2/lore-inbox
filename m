Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTJTQkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTJTQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:40:15 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:4336 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262622AbTJTQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:40:12 -0400
Date: Mon, 20 Oct 2003 10:38:40 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rereading the Partition Table (ioctl BLKRRPART)
Message-ID: <20031020103840.J17778@schatzie.adilger.int>
Mail-Followup-To: "Calin A. Culianu" <calin@ajvar.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0310201121350.17966-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0310201121350.17966-100000@rtlab.med.cornell.edu>; from calin@ajvar.org on Mon, Oct 20, 2003 at 11:38:17AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2003  11:38 -0400, Calin A. Culianu wrote:
> Anyhow, in my quest to keep my uptime as high as possible, I was wondering
> how feasible it would be to make the BLKRRPART ioctl a little more
> flexible, so that in some cases a reboot wouldn't be required.
> 
> Well, what do you guys think?  I am tempted to just hack the sources now
> to get this working for myself, but before I start I am afraid maybe the
> situation isn't quite so simple... or there might be something I am
> overlooking.  Can someone with more experience in the kernel share their
> thoughts on this?

It already exists, and newer partition editors already support this.  I
think parted and partx will use the new partition ioctls to change the
kernel's partition table without a reboot.  Sadly, no documentation on
how to use partx.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

