Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUJQU3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUJQU3v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUJQU1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:27:54 -0400
Received: from zero.aec.at ([193.170.194.10]:49680 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269290AbUJQU0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:26:25 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: auouo@tin.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in
 arch/i386 - intro
References: <2QlVm-7u4-13@gated-at.bofh.it> <2Qmok-7KK-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 17 Oct 2004 22:26:21 +0200
In-Reply-To: <2Qmok-7KK-1@gated-at.bofh.it> (Ingo Molnar's message of "Sun,
 17 Oct 2004 18:50:04 +0200")
Message-ID: <m3ekjxxf9u.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
>
> 2) i dont like the pr_print name at all. What's wrong with Dprintk or
> dprintk? Just define them in kernel.h, this will also make your patch
> much smaller.

I prefer to declare them in subsystem specific files. This way you
can easily enable/disable debugging for only specific files, 
not for everything.

-Andi

