Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSKRLHH>; Mon, 18 Nov 2002 06:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSKRLHG>; Mon, 18 Nov 2002 06:07:06 -0500
Received: from hermes.domdv.de ([193.102.202.1]:23557 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262215AbSKRLHG>;
	Mon, 18 Nov 2002 06:07:06 -0500
Message-ID: <3DD8CC44.9060104@domdv.de>
Date: Mon, 18 Nov 2002 12:17:24 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Vergoz Michael <mvergoz@sysdoor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <3DD8AD5D.9010803@pobox.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
just as a hint: I do have a SiS based UP test system around that 
misbehaves with IO-APIC enabled.
See 
http://www.msi.com.tw/program/products/slim_pc/slm/pro_slm_detail.php?UID=134&MODEL=MS-6232 
  for more system details.
 From the back of my head: with IO-APIC enabled and 3 RTL8139 (one on 
board, the other two PCI) the NICs get assigned IRQs 17 and 18 but don't 
seem to receive any interrupt at all. Without IO-APIC all three NICs 
share IRQ 11 and do work. Further details on request (very low priority 
problem for me). Oh, nearly forgot: kernel is 2.4.20rc1.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

