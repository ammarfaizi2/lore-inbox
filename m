Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUBXOGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUBXOGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:06:06 -0500
Received: from piro.phys2.uniroma1.it ([151.100.123.25]:45960 "EHLO
	piro.phys2.uniroma1.it") by vger.kernel.org with ESMTP
	id S262172AbUBXOGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:06:03 -0500
Subject: yenta pcmcia driver
From: Cristiano De Michele <demichel@na.infn.it>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Physics, University of Naples "Federico II"
Message-Id: <1077631560.4546.26.camel@piro>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 15:06:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have a compaq evo n1015v laptop with 
a Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
and with kernel 2.4.24 I had no problem loading
yenta_socket module 
but with kernel 2.6.3 I get and mce (machine
check exception) error
doing /etc/init.d/pcmcia start
if I include ports 0x100-0x4ff
in /etc/pcmcia/config.opts
the workaround of course is to prevent such ports
from being probed or to use nomce kernel option but I wonder if there's
any
bug in yenta_socket driver of kernel 2.6.3,

thanks for your attention
Cristiano

-- 
Cristiano De Michele <demichel@na.infn.it>
Department of Physics, University of Naples "Federico II"
