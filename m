Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTEOFvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTEOFvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:51:38 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:39420 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263731AbTEOFvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:51:37 -0400
Date: Thu, 15 May 2003 00:04:17 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT write to file by block-aligned, block-multiple buf fails?
Message-ID: <20030515000417.D10503@schatzie.adilger.int>
Mail-Followup-To: Scott McDermott <vaxerdec@frontiernet.net>,
	linux-kernel@vger.kernel.org
References: <20030515013350.B1540@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030515013350.B1540@newbox.localdomain>; from vaxerdec@frontiernet.net on Thu, May 15, 2003 at 01:33:50AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15, 2003  01:33 -0400, Scott McDermott wrote:
> This should mean I can write aligned pages with direct IO, right?
> 
>         write: Invalid argument
> 
>         $ grep /tmp /proc/mounts
>         /dev/hda5 /mnt/tmp ext3 rw 0 0

ext3 does not support O_DIRECT in 2.4 yet.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

