Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSGJUmK>; Wed, 10 Jul 2002 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGJUmJ>; Wed, 10 Jul 2002 16:42:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317616AbSGJUmI>; Wed, 10 Jul 2002 16:42:08 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
To: cort@fsmlabs.com (Cort Dougan)
Date: Wed, 10 Jul 2002 22:07:12 +0100 (BST)
Cc: rml@tech9.net (Robert Love), vherva@niksula.hut.fi (Ville Herva),
       linux-kernel@vger.kernel.org
In-Reply-To: <20020710142005.U762@host110.fsmlabs.com> from "Cort Dougan" at Jul 10, 2002 02:20:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SOg4-0007oM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why was the rate incremented to maintain interactive performance?  Wasn't
> that the whole idea of the pre-empt work?  Does the burden of pre-empt
> actually require this?

Bizarrely in many cases it increases throughput

> It seems that the added inefficiency of these extra interrupts is going to
> drag performance down.

Sometimes - Beowulf folks already sometimes hack the clock down to 20Hz or
less. This is best approached on sane hardware by extending the S/390 stuff
for no regular ticks.

