Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261190AbRFFJTF>; Wed, 6 Jun 2001 05:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbRFFJS4>; Wed, 6 Jun 2001 05:18:56 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:10057 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261190AbRFFJSv>; Wed, 6 Jun 2001 05:18:51 -0400
Message-ID: <001f01c0ee5c$40d3fb10$3303a8c0@einstein>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E157KV1-00077L-00@the-village.bc.nu> <3B1DD68A.17C8FD52@TeraPort.de>
Subject: Re: 2.4.5 VM
Date: Wed, 6 Jun 2001 09:42:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  On a side question: does Linux support swap-files in addition to
> sawp-partitions? Even if that has a performance penalty, when the system
> is swapping performance is dead anyway.


Yes.
A possible solution could be:

> dd if=/dev/zero of=/swap bs=1M count=<whatever you like in MB>
> mkswap /swap
> swapon /swap

Works fine for me.

