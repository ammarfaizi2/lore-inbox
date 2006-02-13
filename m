Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWBMROB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWBMROB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWBMROB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:14:01 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:45402 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932249AbWBMROA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:14:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CuHXN4/L2nuY7ZJbCvRW98UzRZ8z/UGyPSEg9qQOa14VHgHrVNdt0JL/GRWNaf1lF2sN/k1yyqiIlf8Rfw8YsAXsIBMEu8SNFu1hVanwUBKPx1CnAN2gf5RXbiEizLH/pPQpcI8Rg+54/Wfx9lt+y8Bkb/X79n97gC4RGM04iwE=
Message-ID: <d120d5000602130913t2e7a00a6ic86b7c81c0c10b9c@mail.gmail.com>
Date: Mon, 13 Feb 2006 12:13:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Meelis Roos <mroos@linux.ee>
Subject: Re: psmouse starts losing sync in 2.6.16-rc2
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0602051443460.17326@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOC.4.61.0602051443460.17326@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/06, Meelis Roos <mroos@linux.ee> wrote:
> This is 2.6.16-rc2 on a generic PC - Gigabyte 7ZXE mainboard with AMD
> Duron 1300, 896M RAM, PS2/keyboard, PS/2 mouse, ATA disk, 2 PCI NICs
> (rtl8139c), Matrox AGP Graphics, BT878 TV card. There were no psmouse
> probmes with up to 2.6.15. 2.6.16-rc1 not tested since iptables was
> broken.
>
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard as /class/input/input0
> input: PC Speaker as /class/input/input1
> input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
> [...]
> psmouse.c: resync failed, issuing reconnect request
> input: ImExPS/2 Generic Explorer Mouse as /class/input/input3
> psmouse.c: resync failed, issuing reconnect request
> input: ImExPS/2 Generic Explorer Mouse as /class/input/input4
> psmouse.c: resync failed, issuing reconnect request
> input: ImExPS/2 Generic Explorer Mouse as /class/input/input5
>

Does this happen every time you leave mouse idle fore more than 5 sec?

--
Dmitry
