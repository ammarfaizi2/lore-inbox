Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289119AbSAJCOG>; Wed, 9 Jan 2002 21:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSAJCN4>; Wed, 9 Jan 2002 21:13:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61957 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289119AbSAJCNm>; Wed, 9 Jan 2002 21:13:42 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: landley@trommello.org (Rob Landley)
Date: Thu, 10 Jan 2002 02:25:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201091932.g09JW9A27178@snark.thyrsus.com> from "Rob Landley" at Jan 09, 2002 06:44:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OUu0-00035o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you want an operating system capable of running real-world code written by 
> people who know more about their specific problem domain (audio) than about 
> optimal coding in general, or do you want an operating system intended to 
> only run well-behaved applications designed and implemented by experts?

I want an OS were a reasonably cluefully written audio program works. That
to me means aiming at the 1mS latency mark. Which doesn't seem to be needing
pre-empt. Beyond a typical 1mS latency you have hardware fun to worry about,
and the BIOS SMM code eating you.
