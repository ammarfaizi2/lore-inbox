Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWALOOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWALOOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWALOOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:14:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53549 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030401AbWALOOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:14:09 -0500
Date: Thu, 12 Jan 2006 15:16:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Kedar Sovani <kedars@gmail.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sem2mutex bdev->bd_sem
Message-ID: <20060112141606.GO3945@suse.de>
References: <5edf7fc90601120610h70b824ccs9b1ac0fe955dd1b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edf7fc90601120610h70b824ccs9b1ac0fe955dd1b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Kedar Sovani wrote:
> Here is an obvious sem2mutex patch for the bd_sem relative to 2.6.15.
> 
> 
> Kedar.
> 
> 
> Use mutex instead of semaphore.
> 
> Signed-Off-by: Kedar Sovani <ksovani@kernelcorp.com>

Please compile the patches you submit, there are far too many "sem to
mutex" conversion patches being sent that aren't properly tested. And my
eye spots that this is one of them.

-- 
Jens Axboe

