Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTLaUYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 15:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTLaUYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 15:24:07 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:6055 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265258AbTLaUYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 15:24:04 -0500
From: Willem Riede <wrlk@riede.org>
Subject: Re: ide-scsi for DI-30 and strange messages in dmesg
Date: Wed, 31 Dec 2003 15:24:03 -0500
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2003.12.31.20.24.02.129323@riede.org>
References: <fa.e0q2cec.1f2sao0@ifi.uio.no>
Reply-To: wrlk@riede.org
To: Stef van der Made <svdmade@planet.nl>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 20:02:44 +0000, Stef van der Made wrote:

> 
> On a stock 2.6.0-mm2 kernel I see these 'dumps' into dmesg. I'm using a 
> onstream Di-30 on a Ak32E with a via chipset. Is this normal as I've 
> never seen this symptom before ?
> 
> Debug: sleeping function called from invalid context at kernel/sched.c:1814
> in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<c011bc6b>] __might_sleep+0xab/0xd0
>  [<c011aa0f>] wait_for_completion+0x1f/0x100
>  [<c02343e1>] idetape_wait_for_request+0x71/0x90
>  [<c0235509>] idetape_wait_first_stage+0x69/0x70
>  [<c0235dd9>] idetape_get_logical_blk+0x139/0x260
>  [<c0238378>] idetape_chrdev_ioctl+0x268/0x380
>  [<c0165384>] sys_ioctl+0xf4/0x2b0
>  [<c032abbf>] syscall_call+0x7/0xb

I can only advise that you use ide-scsi + osst instead of ide-tape.
If you have problems with that setup, I will help you.

Regards, Willem Riede.

