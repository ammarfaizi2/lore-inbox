Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUADXSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUADXSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:18:24 -0500
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:19690 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S265719AbUADXSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:18:21 -0500
Message-ID: <007501c3d319$2dc27e30$1530a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: <linux-kernel@vger.kernel.org>
References: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
Subject: Re: Any hope for HPT372/HPT374 IDE controller?
Date: Mon, 5 Jan 2004 00:19:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a HPT 404 (374 chipset). I had all those problems and fixed them
by doing

hdparm -m0 /dev/hd?

in every disk connected to the controller. Someone told me it isn't possible
that helped one bit, but the fact is that it did.

I'm no (kernel) developer, though, so other than reality I have no
arguments.


----- Original Message ----- 
From: <tomwallard@soon.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 04, 2004 23:11
Subject: Any hope for HPT372/HPT374 IDE controller?


> Many people seem to have problems with the Highpoint HPT372 and HPT374 IDE
> controllers. Several months ago there was a thread in which many people
> reported failure and not many people reported success. For example, "hdX:
> lost interrupt" errors right before a crash are a common problem. This was
> happening over a wide range of kernel versions. In my case it happens more
> quickly if there is heavy network or video load at the same time as heavy
> load on this controller. (This is a motherboard with a KT400 chipset).
>
> Have any recent improvements been made? Does anyone have one of these
controllers actually working correctly? Does anyone have any idea where to
> begin tracking this problem down?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

