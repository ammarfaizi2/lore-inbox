Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286966AbRL1SKB>; Fri, 28 Dec 2001 13:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286965AbRL1SJx>; Fri, 28 Dec 2001 13:09:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44042 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286948AbRL1SJm>; Fri, 28 Dec 2001 13:09:42 -0500
Subject: Re: zImage not supported for 2.2.20?
To: linux-kernel-l@nta-monitor.com (Roy Hills)
Date: Fri, 28 Dec 2001 18:19:38 +0000 (GMT)
Cc: kaukasoi@elektroni.ee.tut.fi (Petri Kaukasoina),
        linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> from "Roy Hills" at Dec 28, 2001 05:44:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K1bW-0001K0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, I need to use zImage on my Tecra.  I know that zImage is
> old, and I've heard that support for it will eventually be withdrawn, but I
> don't really have much alternative right now unless there is a patch which
> works around the Tecra's buggy A20 handling.

If your tecra is one with the problem early intel PCI chipsets the
documentation on the workaround is on the intel.com site if you feel
creative 8)

Basically the A20 handling for hardware caches on some of these early chips
was broken. There were real hardware fixes for new boards and a software
workaround for old ones is described in the errata docs for the chip.

> Does anyone know the status of zImage format in modern kernels?
> Is it _supposed_ to be supported under 2.2.recent?  How about 2.4.recent?

It works for me. It is meant to work

Alan
