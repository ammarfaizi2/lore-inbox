Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274967AbTHAWSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274965AbTHAWSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 18:18:03 -0400
Received: from law11-oe34.law11.hotmail.com ([64.4.16.91]:8461 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S274962AbTHAWQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 18:16:59 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
References: <Law11-OE70LwHc9ny7B0000e8d4@hotmail.com> <20030801211300.GA15146@mars.ravnborg.org>
Subject: Re: problems compiling kernel 2.5.75
Date: Fri, 1 Aug 2003 16:16:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE34oyNgDSSyu0000e9f6@hotmail.com>
X-OriginalArrivalTime: 01 Aug 2003 22:16:58.0625 (UTC) FILETIME=[9FC50710:01C3587A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,  I comliled again, I put the bzImage in /boot, generate the image with
mkintrd, now when I enter with the new kernel, I have this message: kernel
Panic: No init found , Try passing init= option to kernel.

How can I do it?

Thanks

----- Original Message -----
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Viaris" <bmeneses_beltran@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, August 01, 2003 3:13 PM
Subject: Re: problems compiling kernel 2.5.75


> On Fri, Aug 01, 2003 at 02:51:32PM -0600, Viaris wrote:
> > Hi all, I ma compiling kernel version 2.5.75, but I have the folloienw
> > error:
> >
> > drivers/built-in.o(.text+0x1d41e): In function `pc_close':
> > : undefined reference to `save_flags'
> Try to disbale SMP (do you need it)?
>
> Sam
>
