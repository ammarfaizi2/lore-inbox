Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276231AbRJYUR6>; Thu, 25 Oct 2001 16:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJYURi>; Thu, 25 Oct 2001 16:17:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276247AbRJYUR2>; Thu, 25 Oct 2001 16:17:28 -0400
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: _deepfire@mail.ru (Samium Gromoff)
Date: Thu, 25 Oct 2001 21:21:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200110251930.f9PJUJl26883@vegae.deep.net> from "Samium Gromoff" at Oct 25, 2001 11:30:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wr07-000683-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> 
> 	Result: 
> 		a) modem dies completely - drops ppp packets at the rate of 75%,
> 		irqtune doesnt affect this behaviour at all

This sounds like you dont have ide unmasking enabled and have an old
IDE setup

