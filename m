Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288038AbSAMTT3>; Sun, 13 Jan 2002 14:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288027AbSAMTTJ>; Sun, 13 Jan 2002 14:19:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288021AbSAMTTB>; Sun, 13 Jan 2002 14:19:01 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: rml@tech9.net (Robert Love)
Date: Sun, 13 Jan 2002 19:30:35 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
        arjan@fenrus.demon.nl, landley@trommello.org (Rob Landley),
        linux-kernel@vger.kernel.org
In-Reply-To: <1010946261.11852.16.camel@phantasy> from "Robert Love" at Jan 13, 2002 01:24:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PqKx-0007kS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wasn't thinking.  Anytime we are in an interrupt handler, preemption
> is disabled.  Regardless of how (or even if) interrupts are disabled. 
> We bump preempt_count on the entry path.  So, no problem.

The code path isnt in an interrupt handler.
