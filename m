Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290792AbSARTsZ>; Fri, 18 Jan 2002 14:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290795AbSARTsP>; Fri, 18 Jan 2002 14:48:15 -0500
Received: from f114.law14.hotmail.com ([64.4.21.114]:53776 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290792AbSARTsH>;
	Fri, 18 Jan 2002 14:48:07 -0500
X-Originating-IP: [203.145.133.194]
From: "Raman S" <raman_s_@hotmail.com>
To: bgerst@didntduck.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: int 0x40
Date: Fri, 18 Jan 2002 11:47:58 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F114oSbloWgIkbXKMpt00021432@hotmail.com>
X-OriginalArrivalTime: 18 Jan 2002 19:47:58.0610 (UTC) FILETIME=[07C6FF20:01C1A059]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, That was it, Thanks so much.....
Raman S
>The IRQ setup code is probably overwriting it.  You'll need to make the
>code in i8259.c skip over vector 0x40 as well as SYSCALL_VECTOR (0x80).
>
>--
>
>				Brian Gerst




_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

