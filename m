Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbSJGPm1>; Mon, 7 Oct 2002 11:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbSJGPm1>; Mon, 7 Oct 2002 11:42:27 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:26352 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263123AbSJGPmY>; Mon, 7 Oct 2002 11:42:24 -0400
Subject: Re: Make 2.5.40-ac5 fails
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger While <RogerWhile@sim-basis.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4.3.2.7.2.20021007173756.00c5c4c0@192.168.6.2>
References: <4.3.2.7.2.20021007173756.00c5c4c0@192.168.6.2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 16:57:45 +0100
Message-Id: <1034006265.25098.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 16:39, Roger While wrote:
> As subject says :
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.40-ac5/kernel/drivers/isdn/hisax/hisax.o

A lot of the ISDN layer hasn't yet been updated to the new locking,
ditto a few bits of the netfilter code

