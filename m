Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRCAPWi>; Thu, 1 Mar 2001 10:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbRCAPW2>; Thu, 1 Mar 2001 10:22:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129638AbRCAPWI>;
	Thu, 1 Mar 2001 10:22:08 -0500
Date: Thu, 1 Mar 2001 16:22:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Mario Hermann <ario@eikon.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a second loop-device with 2.4.2-ac7
Message-ID: <20010301162200.R21518@suse.de>
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de>; from ario@eikon.tum.de on Thu, Mar 01, 2001 at 04:11:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01 2001, Mario Hermann wrote:
> Hello!
> 
> I tried the following commands with 2.4.2-ac7:
> 
> losetup /dev/loop0 test.dat
> losetup /dev/loop1 /dev/loop0
> mke2fs /dev/loop1
> 
> My System reboots immediatly. I tried it with 2.4.2-ac4,ac5 too -> same
> effect.

Oops, will take a look.

-- 
Jens Axboe

