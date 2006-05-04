Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWEDO7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWEDO7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWEDO7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:59:44 -0400
Received: from leitseite.net ([213.239.214.51]:130 "EHLO mail.leitseite.net")
	by vger.kernel.org with ESMTP id S1751474AbWEDO7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:59:43 -0400
Date: Thu, 4 May 2006 16:59:28 +0200 (CEST)
From: Nuri Jawad <lkml@jawad.org>
X-X-Sender: lkml@pc
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
In-Reply-To: <20060504024404.GA17818@redhat.com>
Message-ID: <Pine.LNX.4.64.0605041644260.32501@pc>
References: <20060504024404.GA17818@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, Dave Jones wrote:

> The latter message seems to trigger with certain keyboard switchers
> and again, does nothing but confuse people.

I rather think it's showing us there was a glitch when switching.

I have a mechanical switch that sometimes produces this message, and every 
now and then, the keyboard loses its key repeat time/rate setting.
It often happens when the switch is not turned quickly or firmly enough 
and in such a case I had the keyboard port lock up completely a few times. 
I think the kernel should report such a situation.

If people are "confused" by valid error messages, they can use certain 
proprietary operating systems that hide the ugly truth from them. What's 
next, removing "access beyond end of device"? I want to stay informed if 
my mechanical switch produces glitches. There are electronic ones that 
don't.

It would be nice if kernel messages had a structure that allowed a 
verbosity setting, but until then, non-confused users want the 
information they can get.

Regards, Nuri
