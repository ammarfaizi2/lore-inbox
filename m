Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUD0Guu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUD0Guu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbUD0Guu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:50:50 -0400
Received: from FE-mail04.albacom.net ([213.217.149.84]:16612 "EHLO
	FE-mail04.sfg.albacom.net") by vger.kernel.org with ESMTP
	id S263868AbUD0Guj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:50:39 -0400
Message-ID: <003501c42c24$06e87940$0200a8c0@arrakis>
Reply-To: "Marco Cavallini" <arm.linux@koansoftware.com>
From: "Marco Cavallini" <arm.linux@koansoftware.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <005c01c42b82$60d82f60$0200a8c0@arrakis> <20040426185612.GB28530@kroah.com>
Subject: Re: Problem with CONFIG_USB_SL811HS
Date: Tue, 27 Apr 2004 08:51:09 +0200
Organization: Koan s.a.s.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am facing to a problem using linux-2.4.25-vrs2 and/or 2.4.26-vrs1 (ARM
> > porting).
> > I think this problem come from the linux kernel and not from ARM patch.
> > Seems that there is a problem building SL811 USB hosts because if I
enable
> > CONFIG_USB_SL811HS option
> > the driver seems to be not build and is not running.
>
> What is the build errors you get when trying to build this driver?
>

There is no file.o in drivers/usb/host
and there is no SL811 host in the kernel,
the hc_sl811 is not build although I enable CONFIG_USB_SL811HS option.
TIA

Marco Cavallini
