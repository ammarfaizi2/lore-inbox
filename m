Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTAVT5X>; Wed, 22 Jan 2003 14:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTAVT5X>; Wed, 22 Jan 2003 14:57:23 -0500
Received: from cs78165005.pp.htv.fi ([62.78.165.5]:4839 "EHLO mood")
	by vger.kernel.org with ESMTP id <S263039AbTAVT5W>;
	Wed, 22 Jan 2003 14:57:22 -0500
Date: Wed, 22 Jan 2003 22:06:30 +0200
From: Ville Hallivuori <vph@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
Message-ID: <20030122200630.GA17220@vph.iki.fi>
Reply-To: vph@iki.fi
References: <3E2C8EFF.6020707@tin.it> <3E2C9623.60709@sktc.net> <3E2CD91B.2080305@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2CD91B.2080305@tupshin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't necessarily assume a hardware problem (unless we also include 
> chipset oddities). I get *exactly* one message stating exactly this per 
> boot, and it always come a few seconds after loading the parport and 
> parport_pc modules.

> Jan 20 09:20:07 testing kernel: spurious 8259A interrupt: IRQ7.

I also see this message on every boot... I have two Soyo
SY-KT400 Dragon Ultra mother boards, and the message appears with both
of them. Perhaps it is some VIA oddity?. Anyhow, it does not seem to
have any harmful effects (both boards are rock solid with 2.4.20).

Dec 23 20:34:37 mood kernel: Real Time Clock Driver v1.10e
Dec 23 20:34:37 mood kernel: spurious 8259A interrupt: IRQ7.


-- 
[Ville Hallivuori][vph@iki.fi][http://www.iki.fi/vph/]
[ID 8E1AD461][FP16=C9 50 E2 DF 48 F6 33 62  5D 87 47 9D 3F 2B 07 5D]
[ID 58543419][FP20=8731 941D 15AB D4A0 88A0  FC8F B55C F4C4 5854 3419]
[ID 8061C24E][FP20=C722 12DA 841E D811 DBFE  2FB3 174C E291 8061 C24E]
