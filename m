Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVAEV2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVAEV2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVAEV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:28:32 -0500
Received: from bluebottle-fe1.bluebottle.com ([67.107.78.243]:3530 "EHLO
	bluebottle-fe1.bluebottle.com") by vger.kernel.org with ESMTP
	id S262598AbVAEV1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:27:52 -0500
Message-ID: <1104960434.41dc5bb24c4f6@bluebottle.com>
Date: Wed,  5 Jan 2005 15:27:14 -0600
From: jago25_98 <jago25_98@bluebottle.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 kernel panic: IDE/SCSI related?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting regular kernel panics with a vanilla 2.6.10 kernel.

Not sure how to tell which bit is causing the panic from the output
(which isn't logged).

Some of the output noted down by pen+paper:

Process Swapper (pid:0 threading info=c04b8000 task=c042db00)
Stack: ....
Call trace:
[] runtimer.softirq+0x11f/0x170
unknown boot option +0x0/0x...
code: f3....
kernel panic - not syncing: fatal exception in interupt

It crashes about every 2 days, usually when writing to disk but I'm
guessing here.

I have a system with 3 SCSI cards:
Adaptec AHA-2940/2940W
Adaptec AIC-7892A U160/m
American Megatrends Inc. MegaRAID 428 Ultra RAID Controller

An the IDE bus is:
[SiS] 5513

and maybe it could be related to this mix of hardware?

How do I begin to try and diagnose this problem? Really want to help
to fix this if I can.
