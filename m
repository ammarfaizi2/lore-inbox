Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbSJLGde>; Sat, 12 Oct 2002 02:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJLGde>; Sat, 12 Oct 2002 02:33:34 -0400
Received: from fastmail.fm ([209.61.183.86]:58499 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S262814AbSJLGdd>;
	Sat, 12 Oct 2002 02:33:33 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034404761
X-Sasl-enc: fK6aPWMEfOFAjIkL0epBFw
Message-ID: <0fe701c271b9$e86ea910$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook> <3DA791E0.F0A1B11@digeo.com>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sat, 12 Oct 2002 16:37:55 +1000
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


> If it was this, one would expect it to happen every time you'd written
> 0.75 * 192 Mbytes to the filesystem.  Which seems about right.
>
> Easy enough to test though.

Hmmm, so why wouldn't the journal be flushing more regularly (the 5 seconds
it's claiming in desg), or is that something we should ask on the ext3 list?
Apart from remounting the filesystem, is there any easy way to test this
(again, silly mounted as /, so I think it's a reboot every time to try a new
mounting configuration?)

Thanks

Rob

