Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285200AbRLXSIW>; Mon, 24 Dec 2001 13:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285195AbRLXSIJ>; Mon, 24 Dec 2001 13:08:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15621 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285191AbRLXSH0>; Mon, 24 Dec 2001 13:07:26 -0500
Subject: Re: [PATCH] A slightly smarter dmi_scan.c
To: ioshadi@sltnet.lk (Ishan Oshadi Jayawardena)
Date: Mon, 24 Dec 2001 18:17:10 +0000 (GMT)
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C280D5B.274EC187@sltnet.lk> from "Ishan Oshadi Jayawardena" at Dec 24, 2001 11:23:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IZew-0004lD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > APM can also be compiled as a module.
> 
> Right. Thanks. I blatantly ignored that APM can be built as modules ;(
> The fixed patch is here.

I think I prefer it without all the ifdefs being in the code like that. It is
cleaner to read before the change. I agree the messages being printed might
be confusing in some cases but I don't like the cure.

