Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWGVRAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWGVRAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWGVRAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:00:41 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:21739 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750962AbWGVRAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:00:41 -0400
Date: Sat, 22 Jul 2006 18:00:39 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] GPU device layer patchset (00/07)
In-Reply-To: <44C253BB.10704@garzik.org>
Message-ID: <Pine.LNX.4.64.0607221753390.5320@skynet.skynet.ie>
References: <11535827134076-git-send-email-airlied@linux.ie> <44C253BB.10704@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>
> Where can I find more info on why this might be nice?
> Or simply more info on what this actually does for me?

It does nothing for you yet, it is just step one for getting the DRM and 
framebuffer drivers to co-exist in the driver model world, with the next 
step being allowing a channel of communication between the two layers with 
a view that later I can ask the DRM to disable fbdev or pass info to it..

Why do we not want fbdev and DRM in one driver? as it would break way too 
many existing systems..

It also allows DRM to get called at suspend/resume time.

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

