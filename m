Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUCRRHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUCRRHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:07:36 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:56469 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262766AbUCRRHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:07:33 -0500
Date: Fri, 19 Mar 2004 01:03:38 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Anton Blanchard" <anton@samba.org>
Subject: Re: 2.6.x atkbd.c moaning
Cc: "kernel mailing list" <linux-kernel@vger.kernel.org>
References: <opr41z9zel4evsfm@smtp.pacific.net.th> <20040318120114.GN28212@krispykreme>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr42hoctn4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040318120114.GN28212@krispykreme>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 23:01:14 +1100, Anton Blanchard <anton@samba.org> wrote:

>
>> Why is this and should I investigate further?
> ..
>
>> mice: PS/2 mouse device common for all mice
>> serio: i8042 AUX port at 0x60,0x64 irq 12
>> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
>> serio: i8042 KBD port at 0x60,0x64 irq 1
>> input: AT Translated Set 2 keyboard on isa0060/serio0
>> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
>
> Did this happen recently? If so, does backing out the following patch help?

I think so but later than this changeset 1.34 of 19 December.

The patch has no effect.

Also the mouse screws up after a few hours and becomes unusable.

psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.

I will test backwards which version inttroduced problems.

Regards
Michael
