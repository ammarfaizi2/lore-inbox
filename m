Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSHZKJb>; Mon, 26 Aug 2002 06:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSHZKJb>; Mon, 26 Aug 2002 06:09:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:20731 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318027AbSHZKJb>; Mon, 26 Aug 2002 06:09:31 -0400
Subject: Re: kernel losing time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Volker Kuhlmann <list0570@paradise.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020826011332.GA8440@paradise.net.nz>
References: <20020825105500.GE11740@paradise.net.nz>
	<Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm>
	<20020825215515.GA2965@debill.org>
	<1030320314.16766.25.camel@irongate.swansea.linux.org.uk> 
	<20020826011332.GA8440@paradise.net.nz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 11:15:36 +0100
Message-Id: <1030356936.16651.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 02:13, Volker Kuhlmann wrote:
> Ok, Linux doesn't work with with a VIA 82C586 etc chipset. I plonked a
> 16 bit ISA multi-I/O card with IDE interface into the box, some kind of
> winbond chip. Both integrated IDE interfaces in the BIOS are disabled.
> The problem was worst than ever. How does this happen?

ISA multi I/O without hdparm -u has sometimes done this kind of thing
(since its slow and PIO). Thats seperate to the weird jumps we have seen
from the VIA clock

