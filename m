Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132813AbRC2SXy>; Thu, 29 Mar 2001 13:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRC2SXo>; Thu, 29 Mar 2001 13:23:44 -0500
Received: from malcolm.ailis.de ([62.159.58.30]:18181 "HELO malcolm.ailis.de")
	by vger.kernel.org with SMTP id <S132813AbRC2SXl>;
	Thu, 29 Mar 2001 13:23:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Klaus Reimer <k@ailis.de>
Organization: Ailis
To: Bill Nottingham <notting@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Date: Thu, 29 Mar 2001 20:20:23 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01032910124007.00454@neo> <0103291819180K.00454@neo> <20010329112507.A27209@devserv.devel.redhat.com>
In-Reply-To: <20010329112507.A27209@devserv.devel.redhat.com>
MIME-Version: 1.0
Message-Id: <01032920202300.00483@neo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > modprobe opl3sa2 io=0x538 mss_io=0x530 mpu_io=0x330 irq=5 dma=1 dma2=0
> > isapnp=0
> It would be what you put in the io= parameter. 0x538 does *not* look
> right.

These are the sound-settings in the BIOS:

WSS I/O: 0x530
SBPro I/O: 0x220
Synth I/O: 0x388
IRQ: 5
WSS (Play) DMA: 1
WSS (Rec) DMA & SBPro-DMA: 0
Control I/O: 0x538
MPU I/O: 0x330

The BIOS does not let me modify the I/O settings for Synth, Control and MPU. 
And as I said: The opl3sa2 module was working perfectly in kernel 2.2.17 with 
these settings. And I wonder why the message in syslog says "0x0", no matter 
what I/O address I have specified with the io= parameter.

-- 
Bye, K
[a735 47ec d87b 1f15 c1e9 53d3 aa03 6173 a723 e391]
(Finger k@ailis.de to get public key)
