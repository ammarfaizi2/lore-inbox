Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263210AbUJ2KQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUJ2KQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbUJ2KPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:15:09 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:49682 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S263210AbUJ2KO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:14:57 -0400
Date: Fri, 29 Oct 2004 12:14:51 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
Message-ID: <20041029101451.GA11375@stud.fit.vutbr.cz>
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz> <41821250.70502@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41821250.70502@verizon.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Naah.  I have a piix chipset.  My problem (per David Hinds) is that my 
> laptop is even more b0rken than yours - IBM never hooked up the PCI INTx 
> lines on the TI 1130.  My laptop never worked with Cardbus stuff - even in 
> Windows.
  That's pity :-(. So i don't help you with this because i don't have
similar IBM notebook. Hmmm you should beat out datasheet from IBM :-).

> He reccommended the external pcmcia_cs package for my system - there's a 
> dummy_cs module in there (2.4 only, though) that should fix my problem.
  Yes, external pcmcia_cs drivers works in this situation. But you need
working irq for e.g. cardbus card that have only pci driver in kernel. I
needed this because realtek_cb work bad and i would like to use cardbus
usb controller and some wifi card.

> Thanks,
> 
> Jim
  Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
