Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSGMJJx>; Sat, 13 Jul 2002 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSGMJJw>; Sat, 13 Jul 2002 05:09:52 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:37164 "EHLO
	devil.stev.org") by vger.kernel.org with ESMTP id <S318132AbSGMJJr>;
	Sat, 13 Jul 2002 05:09:47 -0400
Message-ID: <01fd01c22a4d$151c4da0$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Anssi Saari" <as@sci.fi>, <linux-kernel@vger.kernel.org>
References: <002d01c22882$f17436e0$0501a8c0@Stev.org> <E17ScQK-0000ih-00@the-village.bc.nu> <20020712185522.GA12751@sci.fi>
Subject: Re: ATAPI + cdwriter problem
Date: Sat, 13 Jul 2002 10:10:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jul 11, 2002 at 12:47:52PM +0100, Alan Cox wrote:
> > > i also have now tried this under 2.4.19-rc1 which produces the same
> > > problems.
> >
> > Apply the diff below then retry. Let people know if it fixes your atapi
> > problem
>
> Didn't fix mine either. First CD I tried to write on a pdc20265, I just
> got these two messages in kern.log:
>
> ide-scsi: CoD != 0 in idescsi_pc_intr
> hdg: ATAPI reset complete
>
> Too bad Burn-proof can't handle ATAPI resets...

yeah that was 1 of the several different error messages i got.

the really bad thing is the fact that it never does reset
for me a reboot is required for me to use the cd drive again.



