Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289069AbSANVNw>; Mon, 14 Jan 2002 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289067AbSANVNc>; Mon, 14 Jan 2002 16:13:32 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:26364 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289069AbSANVMV>;
	Mon, 14 Jan 2002 16:12:21 -0500
Date: Mon, 14 Jan 2002 14:12:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: dylang+kernel@thock.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 NFS bug (annoying sylmlinx breakage)
Message-ID: <20020114141209.W26688@lynx.adilger.int>
Mail-Followup-To: dylang+kernel@thock.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C43447D.9000504@thock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C43447D.9000504@thock.com>; from dylang@thock.com on Mon, Jan 14, 2002 at 02:50:05PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  14:50 -0600, Dylan Griffiths wrote:
> I've noticed this bug before.  Between two hosts on a 100Mbps switched lan, 
> symlinks are trashed into garbage.  Based on the output. I'm guessing a 
> string loses its null somewhere.
> 
> Client is 2.4.14.  Server is 2.4.10.  Server has RAID 5 IDE softraid and 
> an hpt370 driver patch provided by Tim Hockin to fix the deadlocks and 
> oopsies of the hpt366 driver on my hpt370.

Upgrade your kernel before reporting such bugs.  I'm pretty sure it has
already been fixed.  Something about the NFSv3 calling an inappropriate
(but similarly named) function in the symlink path.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

