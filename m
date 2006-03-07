Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWCGNN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWCGNN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWCGNN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:13:26 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:36320 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1750861AbWCGNNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:13:25 -0500
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: UBIQUAM UM-300 doesn't work with 2.6.16-rc5
Date: Tue, 7 Mar 2006 14:12:31 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071412.32051.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got UBIQUAM UM-300 PCMCIA Type II Card

http://www.ubiquam.com/product/da_um300.php

Socket 0:
  product info: "Ubiquam", "UM-300", "", ""
  manfid: 0x015d, 0x4c45
  function: 254 ((null))

I tried bind it to serial_cs driver, but without success:

PCMCIA_DEVICE_MANF_CARD(0x015d, 0x4c45),

After this addition I got:

pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
pcmcia: registering new device pcmcia0.1
0.1: ttyS2 at I/O 0x3e8 (irq = 10) is a XScale

But when I tried talk to it I got:

serial8250: too much work for irq10
serial8250: too much work for irq10
serial8250: too much work for irq10
serial8250: too much work for irq10
serial8250: too much work for irq10

Any clue?

Thanks and regards

Michal
