Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262732AbTCPSgq>; Sun, 16 Mar 2003 13:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbTCPSgq>; Sun, 16 Mar 2003 13:36:46 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35549
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262729AbTCPSgo>; Sun, 16 Mar 2003 13:36:44 -0500
Subject: Re: RS485 communicatio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ed Vance <EdV@macrolink.com>, "'Linux PPP'" <linuxppp@indiainfo.com>,
       linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030315194646.GB367@elf.ucw.cz>
References: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
	 <20030315194646.GB367@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047844625.21346.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 19:57:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 19:46, Pavel Machek wrote:
> > I believe Point-to-Point Protocol only supports point-to-point symmetric
> > links. Don't think there is any multi-point support in the protocol. IIRC,
> > PPP also requires a full duplex link, which is not available on an RS-485
> > link with more than two stations, even if it is a 4-wire link. 
> 
> Get scarabd (I don't know *where* it is), it can run TCP/IP over slip over
> half-duplex link. Performance is not too good.

Robin O'Leary wrote most of it, so its probably somewhere like
caderus.co.uk

Half duplex performance is fine at a sensible speed and with decent
reliability. On radio will collisions its a lot less pretty

