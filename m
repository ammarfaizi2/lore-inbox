Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTKEImR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 03:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTKEIlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 03:41:17 -0500
Received: from ns.suse.de ([195.135.220.2]:42467 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262608AbTKEIlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 03:41:08 -0500
Date: Wed, 5 Nov 2003 09:40:07 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031105084007.GZ1477@suse.de>
References: <3FA69CDF.5070908@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA69CDF.5070908@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03 2003, Prakash K. Cheemplavam wrote:
> Hi,
> 
> well I am using k3b0.10.1 and either choosing cdrdao or cdrecord in DAO 
> mode to burn the cd ends up in non-bit identical copies, wheres ion TAO 
> (atleast with my 10x CD-RW I tested) the copy succeded. I tried several 
> times, and always got this issue.
> 
> bash-2.05b$ md5sum livecd-2.6_10-23-2003.iso
> f73f3a74239dfe94b322b85fd14a306e livecd-2.6_10-23-2003.iso
> 
> TAO:
> bash-2.05b$ md5sum /dev/cdroms/cdrom1
> f73f3a74239dfe94b322b85fd14a306e /dev/cdroms/cdrom1
> 
> DAO:
> bash-2.05b$ md5sum /dev/cdroms/cdrom1
> 09e7e2a51af4c64685831513fbac18c2 /dev/cdroms/cdrom1

Could you please try and cmp the two images, finding out how big the
corrupted chunks are and what kind of data they contain?

-- 
Jens Axboe

