Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269543AbRHYXDB>; Sat, 25 Aug 2001 19:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRHYXCu>; Sat, 25 Aug 2001 19:02:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30732 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269543AbRHYXCc>; Sat, 25 Aug 2001 19:02:32 -0400
Subject: Re: unrelated 2.4.x (x=0-9) sound
To: _deepfire@mail.ru
Date: Sun, 26 Aug 2001 00:05:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E15alnH-000AZt-00@f8.mail.ru> from "Samium Gromoff" at Aug 25, 2001 10:20:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15amV2-0008M6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     i.e. you mean that PCI-ISA bridge doesnt provide enough
>   realtimeness to fill internal sb buffer?

Yep.

>      i have the next "but": isn`t internal sb buffer
>   enough large to flatten these io peaks?

>From memory the internal buffer is something like 64 or 128 bytes.

>      but next why: why "find /" does not achieve
>   same effect? the datastream is _way_ larger!

It may depend whether the CPU is generating the traffic or not. On some
bridges CPU generated writes win all bus arbitrations by default
