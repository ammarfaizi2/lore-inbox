Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWG3STO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWG3STO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWG3STO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:19:14 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:8665 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932403AbWG3STN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:19:13 -0400
Date: Sun, 30 Jul 2006 20:17:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Andi Kleen <ak@suse.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
In-Reply-To: <44CCF63B.6070906@argo.co.il>
Message-ID: <Pine.LNX.4.61.0607302016340.25626@yvahk01.tjqt.qr>
References: <p73u04z2dzu.fsf@verdi.suse.de> <44CCF63B.6070906@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Cannot work on x86-64, even disregarding fp exceptions, because
> kernel_fpu_begin() doesn't save the sse state which is used by fp math.
>
> No?

No. You can - if you want - exclusively use x87 math on x64 (at least for 
userspace) and don't care about SSE. Otherwise, GCC having a -mfpmath=387 
would be pretty useless.

No?


Jan Engelhardt
-- 
