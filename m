Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271716AbRHQRsl>; Fri, 17 Aug 2001 13:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271715AbRHQRsa>; Fri, 17 Aug 2001 13:48:30 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:51190 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269391AbRHQRsQ>; Fri, 17 Aug 2001 13:48:16 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 11:48:20 -0600
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error on fs unmount
Message-ID: <20010817114820.D17372@turbolinux.com>
Mail-Followup-To: Peter Klotz <peter.klotz@aon.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01081718390800.01143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01081718390800.01143@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  18:39 +0200, Peter Klotz wrote:
> Kernel 2.4.8 produces the following message on almost every shutdown:
> 
> Unmounting filesystems: Trying to _clear_inode of system file 9! Shouldn't 
> happen.

Please tell us what filesystem you are using?

Assuming ext2, please run "e2fsck -f <device>" on the unmounted filesystem.
However, since I've never seen this message before, and e2fsck would run
automatically after such an error I doubt it is ext2 unless there were
recent changes.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

