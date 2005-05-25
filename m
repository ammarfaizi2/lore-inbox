Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVEYIwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVEYIwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEYIwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 04:52:18 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:6173 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261486AbVEYIwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 04:52:11 -0400
Message-ID: <42943CB5.50400@poczta.fm>
Date: Wed, 25 May 2005 10:52:05 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: stlman@poczta.fm
Subject: Driver for MCS7780 USB-IrDA bridge chip
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: 31a42138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Everyone.

I've written, with significant help from MosChip which provided me with
some extra data, the driver for MCS7780. The official documentation
for the chip is available at:

http://moschip.com/data/products/MCS7780/All_7780.zip

The driver is in a *very* early alpha stage but works a little bit.

It can:

* Setup hardware.
* Talk at 9600 bps.
* Receive packets and pass them to irda stack
* Send packets from the stack to the outside world.

It can't:

* Change the speed althoug hardware supports up to 4Mbps FIR mode.
* Handle most of possible errors.
* Make a cup of tea ;-)
* A lot more

The lists are quite equal at length ;) I would like to ask you kindly to
look at my code and maybe, if you have an MCS7780 IR dongle, try it. I
will appreciate any comments, patches and flames.

You can download it from either:

http://www.ee.pw.edu.pl/~stelmacl/mcs7780-0.1alpha.1.tar.bz2

or

http://stlman.fm.interia.pl/mcs7780-0.1alpha.1.tar.bz2

For the record the code is quite havely based on stir4200 driver since
both chips has simmilar principles of operation. They both need a
software do the framing for them. I also borrowed ;) the makfile from
the Broadcom Gigabit Ethernet driver sources.

I am not subscribed to LKML, please CC any answers.

Thank you in advance
Best regards.
-- 
By³o mi bardzo mi³o.                    Trzecia pospolita klêska, [...]
>£ukasz<                      Ju¿ nie katolicka lecz z³odziejska.  (c)PP



----------------------------------------------------------------------
Znajdz swoja milosc na wiosne... >>> http://link.interia.pl/f187a

