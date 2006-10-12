Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWJLSTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWJLSTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWJLSTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:19:39 -0400
Received: from brick.kernel.dk ([62.242.22.158]:7178 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750733AbWJLSTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:19:38 -0400
Date: Thu, 12 Oct 2006 20:19:50 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KDE confuses 2.6.19-rc1+ AKA "cdrom: This disc doesn't have any  tracks I recognize!"
Message-ID: <20061012181950.GO6515@kernel.dk>
References: <20061012162727.207b730c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012162727.207b730c@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Paolo Ornati wrote:
> I'm seeing a very strange problem.
> 
> With every post 2.6.18 kernel I've tried [2.6.19-rc1 -->
> 2.6.19-rc1-gc25d5180], the kernel is "confused" by KDE.
> 
> If I boot without starting KDE and put in a CD/DVD it works correctly.
> 
> If I start KDE and then put in a CD the kernel tells:
> 	cdrom: This disc doesn't have any tracks I recognize!
> 
> Manually mount still works but KDE shows it as a blank CD and I
> cannot mount it through "media:/".
> 
> 
> The kernel stays "confused" even if I close KDE...
> 
> I'm using KDE 3.5.4.

Try current -git, it should be fixed now.

-- 
Jens Axboe

