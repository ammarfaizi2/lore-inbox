Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRLBPHQ>; Sun, 2 Dec 2001 10:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRLBPGz>; Sun, 2 Dec 2001 10:06:55 -0500
Received: from m1000.netcologne.de ([194.8.194.104]:24686 "EHLO
	m1000.netcologne.de") by vger.kernel.org with ESMTP
	id <S279902AbRLBPGs>; Sun, 2 Dec 2001 10:06:48 -0500
Message-ID: <008001c17b42$e2fa5880$30d8fea9@ecce>
From: "[MOc]cda*mirabilos" <mirabilos@netcologne.de>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0112011654550.1696-100000@blue1.dev.mcafeelabs.com>
Subject: Re: [PATCH] task_struct colouring ...
Date: Sun, 2 Dec 2001 15:06:06 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > movl %esp, %eax
> > > andl $-8192, %eax
> > > movl (%eax), %eax
> >
> > Although I'm good in assembly but bad in gas,
> > do you consider the middle line good style?
> >
> > Binary AND with a negative decimal number?
> 
> ~N = -(N + 1)

I know, but I don't consider this good style, as
decimal arithmetic is for humans, and binary
{arithmetic,ops} are for the PC.

Please don't Cc: me, I read the list, thanks.

Thorsten


