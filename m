Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130450AbRCLU3Y>; Mon, 12 Mar 2001 15:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130588AbRCLU3E>; Mon, 12 Mar 2001 15:29:04 -0500
Received: from colorfullife.com ([216.156.138.34]:28676 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130450AbRCLU26>;
	Mon, 12 Mar 2001 15:28:58 -0500
Message-ID: <001b01c0ab33$07ff5670$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200103122008.XAA11117@ms2.inr.ac.ru>
Subject: Re: Feedback for fastselect and one-copy-pipe
Date: Mon, 12 Mar 2001 21:28:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <kuznet@ms2.inr.ac.ru>
>
> > freebsd
>
> Very funny, the idea is borrowed from there.
>
> As you could understand your patch kills it. PAGE_SIZE is one of the
most
> frequently used transfer unit.
>

freebsd-4.0 doesn't use direct transfers for PAGE_SIZE'd pipe write()s:
it uses  MINDIRECT=8192. (and PIPE_BUF is 512, so 4096 was possible for
them)


--
    Manfred

