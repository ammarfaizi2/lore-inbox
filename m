Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318960AbSIIVBD>; Mon, 9 Sep 2002 17:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318961AbSIIVBD>; Mon, 9 Sep 2002 17:01:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:3056 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318960AbSIIVBB>; Mon, 9 Sep 2002 17:01:01 -0400
Subject: Re: Western Digital hard drive and DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: jbradford@dial.pipex.com, adamjaskie@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200209090219.g892Jhm7015294@pincoya.inf.utfsm.cl>
References: <200209090219.g892Jhm7015294@pincoya.inf.utfsm.cl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 22:08:14 +0100
Message-Id: <1031605694.29718.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 03:19, Horst von Brand wrote:
> Use DMA for a week or so, and / is mangled beyond recognition (seems to
> happen with read-only access too). Chipset is intel (sr440bx board, PIIX4E
> IDE). Have heard of similar problems with DMA on WD drives, but got no
> details.

Old old (we are talking 340MB era here) WD had some DMA problems in a
few cases. We know about it and blacklist such drives. I'm aware of a
few "UDMA doesnt work" type incompatibilities with WD drives but not
with PIIX and always UDMA crc errors

