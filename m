Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSL3A7X>; Sun, 29 Dec 2002 19:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSL3A7X>; Sun, 29 Dec 2002 19:59:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25984
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264944AbSL3A7U>; Sun, 29 Dec 2002 19:59:20 -0500
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: khromy <khromy@lnuxlab.ath.cx>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230012045.GA25428@lnuxlab.ath.cx>
References: <20021229202610.GA24554@lnuxlab.ath.cx>
	<3E0F5E2C.70F7D112@digeo.com>
	<1041211946.1474.31.camel@irongate.swansea.linux.org.uk> 
	<20021230012045.GA25428@lnuxlab.ath.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 01:49:02 +0000
Message-Id: <1041212942.1172.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 01:20, khromy wrote:
> > DMA RAM around. All the sound works this way because few bits of sound
> > hardware, even in the PCI world, support scatter gather.
> 
> This is a PCI sound card.
> 
>   Bus  0, device  11, function  0:
>       Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).

And doesn't support scatter gather either so does the same thing.

