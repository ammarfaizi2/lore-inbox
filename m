Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTA2PDw>; Wed, 29 Jan 2003 10:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTA2PDw>; Wed, 29 Jan 2003 10:03:52 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:43671 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S265670AbTA2PDv>; Wed, 29 Jan 2003 10:03:51 -0500
Message-ID: <055801c2c7a8$b09f2c90$1d00a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <kuznet@ms2.inr.ac.ru>, "David C Niemi" <lkernel2003@tuxers.net>
Cc: <davem@redhat.com>, <benoit-lists@fb12.de>, <cgf@redhat.com>,
       <andersg@0x63.nu>, <lkernel2003@tuxers.net>,
       <linux-kernel@vger.kernel.org>, <tobi@tobi.nu>
References: <200301291424.RAA32107@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
Date: Wed, 29 Jan 2003 16:11:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello!
>
> > Odd, then, that it I was unable to reproduce the SSH hangs under 2.4.18
>
> The bug is there, but it cannot be triggered with ssh.
> In 2.4 it can happen only on sockets which use sendfile().
>
> Alexey
>

Thanks VERY much Alexey for your fast fix.

Back to linux 2.5.59, is the TOS 0x10 mandatory to have such hangs, or are
all TCP sessions potentially candidates ?

Eric

