Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281297AbRKPK7l>; Fri, 16 Nov 2001 05:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281299AbRKPK7b>; Fri, 16 Nov 2001 05:59:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22789 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281295AbRKPK7N>; Fri, 16 Nov 2001 05:59:13 -0500
Subject: Re: infinite loop in 3c509 driver IRQ loop?
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Fri, 16 Nov 2001 11:07:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel mailing list)
In-Reply-To: <20011116114902.K5520@emma1.emma.line.org> from "Matthias Andree" at Nov 16, 2001 11:49:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164gpo-0003fJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I caught a complaint by Linux 2.2.19 which has a 3C509B that it ran into
> an infinite loop in its IRQ handler. Driver bug?

It means the card kept having work left to do - eg because it was under
extreme load at that point. Its not neccessarily a bug - did the box then
recover ?
