Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRIXOJt>; Mon, 24 Sep 2001 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273921AbRIXOJj>; Mon, 24 Sep 2001 10:09:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41480 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273918AbRIXOJ2>; Mon, 24 Sep 2001 10:09:28 -0400
Subject: Re: 2.4.10-pre15 -> final breaks IOAPIC on UP?
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Mon, 24 Sep 2001 15:15:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel mailing list), mingo@redhat.com
In-Reply-To: <20010924155804.A5540@emma1.emma.line.org> from "Matthias Andree" at Sep 24, 2001 03:58:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lWVi-0002eV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I believe that any IOAPIC related change between 2.4.10-pre15 and
> 2.4.10-final breaks my X11 here.

Uniprocessor IO-APIC only works for some machines. It also subtly changes
IRQ delivery timing properties which may be worth checking too

Alan

