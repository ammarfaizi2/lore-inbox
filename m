Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbRGUQaS>; Sat, 21 Jul 2001 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267718AbRGUQaI>; Sat, 21 Jul 2001 12:30:08 -0400
Received: from pop.gmx.net ([194.221.183.20]:22267 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267713AbRGUQ34>;
	Sat, 21 Jul 2001 12:29:56 -0400
Message-ID: <002f01c11202$60f22100$c20e9c3e@host1>
From: "peter k." <spam-goes-to-dev-null@gmx.net>
To: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCECBCKAA.davids@webmaster.com>
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Date: Sat, 21 Jul 2001 18:29:37 +0200
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
Original-Recipient: rfc822;linux-kernel-outgoing


> > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0"
> > is started
> > automatically when booting (by the kernel obviously)? why? what
> > does it do?
> > i didnt find any useful information on it in linuxdoc / linux-kernel
> > archives
>
> It's the kernel soft IRQ daemon. It provides a context from which to
> execute 'slow' code that was triggered by an interrupt. There will be one
> per CPU.
>
> DS

why wasnt it run in previous kernels? im just wondering why it suddenly
appeared without anyone saying a word about it ;)

