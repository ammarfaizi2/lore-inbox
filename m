Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRJUPQP>; Sun, 21 Oct 2001 11:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276248AbRJUPQF>; Sun, 21 Oct 2001 11:16:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276247AbRJUPQA>; Sun, 21 Oct 2001 11:16:00 -0400
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
To: taral@taral.net (Taral)
Date: Sun, 21 Oct 2001 16:22:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011019103041.D30774@taral.net> from "Taral" at Oct 19, 2001 10:30:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vKR6-0006g5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also think this is somewhat ridiculous. If I (the binary module maker)
> distribute a program which effectively replicates the functionality of
> insmod without the licence checking, and distribute that program with my
> module, am I violating any restrictions? I don't think so, since it's
> the end-user that ends up linking the kernel to the module. No linked
> products are actually distributed...

You are arguably obtaining services by deception, and possibly also
violating a content management system.

However the MODULE_LICENSE isn't aimed at people like that. In fact I've had
totally positive responses from people who ship well known binary modules
and understand why we want them to get bugs related to their code.

The people bright enough to hack insmod generally are also bright enough to
realise why its a bad idea.

Alan
