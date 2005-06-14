Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFNFuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFNFuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFNFuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:50:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9681 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261231AbVFNFtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:49:53 -0400
Date: Tue, 14 Jun 2005 07:47:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] IDE CD reports current speed
Message-ID: <20050614054752.GB1484@suse.de>
References: <42AE09BB.2090201@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AE09BB.2090201@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14 2005, Eric Piel wrote:
> Hello,
> 
> The current ide-cd driver reports the CDROM speed (as found in 
> /proc/sys/dev/cdrom/info) as the current speed when loading the driver. 
> Changing the speed of the cdrom drive (by "eject -x" for instance) 
> doesn't update the speed reported by the kernel. Updating the info could 
> be valuable for the user as it's the only way to know if the drive 
> accepted the request or discarded it. It could even be used to list all 
> the available speeds of the drive.
> 
> The attached patch modifies the ide-cd driver so that after every speed 
> change request the new speed is updated. Please note that the actual 
> modification is very little but I had to touch quite a few lines in 
> order to avoid to pre-declare the sub-functions.
> 
> Please, let me know if that sounds a good behaviour for the CDROM 
> interface. I hope you apply :-)

Looks sane, thanks.

-- 
Jens Axboe

