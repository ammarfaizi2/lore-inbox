Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSJMGJ5>; Sun, 13 Oct 2002 02:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJMGJ5>; Sun, 13 Oct 2002 02:09:57 -0400
Received: from fastmail.fm ([209.61.183.86]:50839 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S261433AbSJMGJ5>;
	Sun, 13 Oct 2002 02:09:57 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034489745
X-Sasl-enc: ugq1q/XpsVytjnvf6xijEA
Message-ID: <111e01c2727f$c62239a0$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook> <3DA791E0.F0A1B11@digeo.com> <0fe701c271b9$e86ea910$1900a8c0@lifebook> <3DA7C4C2.58BCE2BC@digeo.com> <0ff701c271bb$f2e8a0b0$1900a8c0@lifebook> <3DA7C87A.670EDD45@digeo.com>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 16:14:18 +1000
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


> > So you're saying that ext3 is somehow breaking the standard kernel
writeback
> > code?
>
> Possibly.  Please try ordered mode.

Ok, we've now tried ordered mode, and are seeing exactly the same behaviour,
no change. No processes in a waiting state or blocked state at all, but
still big load spikes. See my other post for an alternating uptime/ps
output.

> Not yet.  Yours is only the second report.  Possible report.
> Please try ordered mode.  The below will fix journalled
> mode, if this is indeed the source of the problem

We tried applying this patch, but no change either. Again, we've tried both
journaled and ordered.

Rob

