Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274062AbRI0XCc>; Thu, 27 Sep 2001 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274053AbRI0XCW>; Thu, 27 Sep 2001 19:02:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274062AbRI0XCF>; Thu, 27 Sep 2001 19:02:05 -0400
Subject: Re: Linux 2.4.9-ac16
To: trini@kernel.crashing.org (Tom Rini)
Date: Fri, 28 Sep 2001 00:06:44 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010927120353.M13535@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Sep 27, 2001 12:03:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mkEu-0005QS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4.9-ac16
> [snip]
> > o	Add initial pieces for EXPORT_SYMBOL_GPL	(me)
> > 	| kernel symbols for GPL only use
> 
> What's the idea behind this?  Are we now going to restrict certain parts of
> the kernel to interacting with GPL-only modules?

Imagine you have a shared library of code that makes writing some kind of
driver easier, and you don't see why it should be available to non GPL
driver modules. 

Linus has made it absolutely (as in he'll send out the killer penguin with
chainsaw if need be) clear that existing symbols wont mysteriously turn GPL 
only.

Alan

