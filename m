Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289871AbSBFAHl>; Tue, 5 Feb 2002 19:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSBFAHW>; Tue, 5 Feb 2002 19:07:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289871AbSBFAHN>; Tue, 5 Feb 2002 19:07:13 -0500
Subject: Re: How to check the kernel compile options ?
To: Andries.Brouwer@cwi.nl
Date: Wed, 6 Feb 2002 00:20:16 +0000 (GMT)
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200202052356.g15Nu1w00794.aeb@apps.cwi.nl> from "Andries.Brouwer@cwi.nl" at Feb 06, 2002 12:56:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YFou-0003Nm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, you should ponder whether it is worthwhile to pay this cost of zero,
> and ponder whether it is worthwhile to pay this cost of 5 kB.

If you are going to cat it onto the end of the kernel image just mark 
it __initdata and shove a known symbol name on it. It'll get dumped out
of memory and you can find it trivially by using tools on the binary
