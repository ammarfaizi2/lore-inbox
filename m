Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280361AbRKEIit>; Mon, 5 Nov 2001 03:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280363AbRKEIik>; Mon, 5 Nov 2001 03:38:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7181 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280361AbRKEIi1>; Mon, 5 Nov 2001 03:38:27 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
To: maze@druid.if.uj.edu.pl (Maciej Zenczykowski)
Date: Mon, 5 Nov 2001 08:45:05 +0000 (GMT)
Cc: jdthood@mail.com (Thomas Hood), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111050149580.27009-700000@druid.if.uj.edu.pl> from "Maciej Zenczykowski" at Nov 05, 2001 02:18:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160fNR-0004fu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well here you have it...
> 
> W98SE reports the FDC at 0x3f0..0x3f5 and 0x3f7

Its absolutely correct. 0x3f6 isnt floppy. That I suspect is what
is causing the problem because it tries to grab 0x3f6 in Linux
