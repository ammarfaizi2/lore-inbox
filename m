Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbTHBTDV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270214AbTHBTDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:03:21 -0400
Received: from law11-oe70.law11.hotmail.com ([64.4.16.205]:54538 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270210AbTHBTDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:03:18 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
References: <Law11-OE70LwHc9ny7B0000e8d4@hotmail.com> <20030801211300.GA15146@mars.ravnborg.org>
Subject: Re: problems compiling kernel 2.5.75
Date: Sat, 2 Aug 2003 13:03:15 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE708awYFDIfW0000fc44@hotmail.com>
X-OriginalArrivalTime: 02 Aug 2003 19:03:17.0247 (UTC) FILETIME=[BB4D38F0:01C35928]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Ok, now my new kernel 2.5.75 is fine, but I have problems with the CDROM,
this new kernel no found /dev/cdrom, my CDROM is IDE, how can I To resolv
this problem?

Thanks in Advanced,

Regards,

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
