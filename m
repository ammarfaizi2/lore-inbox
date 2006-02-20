Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWBTOfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWBTOfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWBTOfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:35:47 -0500
Received: from rtr.ca ([64.26.128.89]:2018 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030253AbWBTOfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:35:46 -0500
Message-ID: <43F9D3CA.1010709@rtr.ca>
Date: Mon, 20 Feb 2006 09:35:54 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: 2.6.16-rc[34]: resume-from-RAM unreliable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the past week, I've been trying to keep with the latest -rc*-git*
releases of 2.6.16 on my notebook, and something new in those is
impacting resume-from-RAM.

It works most of the time, but *rarely* when suspended for more
than a few hours (like overnight).  Which makes testing somewhat
challenging, as this is also my main work machine.

Black screen on resume, no response to alt-sysrq-b,
and no convenient serial port in the machine.

Works 100% with 2.6.15 kernels.

If I can figure out anything more that's useful, I'll do so,
but that's all I know about it right now.

Debugging resume on a "legacy free" notebook is not fun.

-ml
