Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVGLQXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVGLQXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGLQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:23:11 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:5865 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S261561AbVGLQVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:21:19 -0400
Date: Tue, 12 Jul 2005 19:21:06 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Mikael Pettersson <mikpe@csd.uu.se>, gregkh@suse.de, jonsmirl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
In-Reply-To: <20050712200742.A13716@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0507121920320.27796@tukki.cc.jyu.fi>
References: <200507081354.j68Ds02b020296@harpo.it.uu.se>
 <20050712174119.A31613@jurassic.park.msu.ru> <Pine.GSO.4.58.0507121856050.27617@tukki.cc.jyu.fi>
 <20050712200742.A13716@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Tue, 12 Jul 2005 19:21:08 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Ivan Kokshaysky wrote:

> On Tue, Jul 12, 2005 at 07:00:37PM +0300, Tero Roponen wrote:
> > It seems that everything is fine until some module
> > loads and does something.
>
> What does your /proc/ioports say under 2.6.12 with all modules
> loaded?
>
> Ivan.

cat /proc/ioports under 2.6.12 gives this:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
0300-030f : pcmcia_socket1
0330-0331 : MPU401 UART
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
04d0-04d1 : pnp 00:0a
0530-0533 : CS4231
0538-053f : CS4232 Control
0cf8-0cff : PCI conf1
15e0-15ef : pnp 00:0a
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
4800-48ff : PCI CardBus #05
4c00-4cff : PCI CardBus #05
9000-901f : 0000:00:06.2
ef00-ef3f : 0000:00:06.3
efa0-efbf : 0000:00:06.3
fcf0-fcff : 0000:00:06.1
  fcf0-fcf7 : ide0


-
Tero Roponen
