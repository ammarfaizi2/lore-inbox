Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUGNWlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUGNWlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUGNWlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 18:41:04 -0400
Received: from cust.18.243.adsl.cistron.nl ([62.216.18.243]:23680 "EHLO
	nemiahone.tser.org") by vger.kernel.org with ESMTP id S265960AbUGNWlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 18:41:00 -0400
From: "Reinder" <tser@dwaal.net>
To: <linux-kernel@vger.kernel.org>
Subject: After porting the via vt8231.c driver to 2.6.X i see it 3 times in sensors.
Date: Thu, 15 Jul 2004 00:41:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRp87GPkCC2VCgZRxegzmtcURX/GA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
Message-Id: <20040714233939.2F6AF14DC10A@nemiahone.tser.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

After not being able to find the vt8231 module for the latest 2.6.X Kernel ,
i merged the i2c/chips/VT8231.C to 2.6.X , and it's working almost ok, but i
have  a strange output, it's showing up 3 times like this :

vt8231-isa-fffe
.. bla..
vt8231-isa-6000
.. bla..
vt8231-isa-0000
..bla..

Somehow, i managed to let the system think it was 3 times inserted (?)

Can somebody shine a small light on this ? i promise i won't bother you guys
to much.
I have placed the code at : http://www.tser.org/vt8231/

I have to fix some small other bits before it's ok. But i think i will
manage that. (like as correcting the 12V :)

Kinds regards
		Reinder Kraaij.

-----------
vt8231-isa-6000
Adapter: ISA adapter
VCore1:    +5.64 V  (min =  +0.10 V, max =  +7.20 V)   
+5V:       +8.68 V  (min =  +0.26 V, max = +16.05 V)   
+12V:     +78.04 V  (min =  +1.72 V, max = +92.67 V)   
+3.3V:     +0.48 V  (min =  +0.48 V, max =  +0.48 V)   
fan1:     5160 RPM  (min =    0 RPM, div = 2)          
fan2:     6301 RPM  (min =    0 RPM, div = 2)          

