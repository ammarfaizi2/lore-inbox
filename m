Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTI2RcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTI2Rbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:31:45 -0400
Received: from fep03.swip.net ([130.244.199.131]:678 "EHLO fep03-svc.swip.net")
	by vger.kernel.org with ESMTP id S263911AbTI2RbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:31:00 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 3C59x module doesn't work in 2.6.0-test6
Date: Mon, 29 Sep 2003 19:30:57 +0200
User-Agent: KMail/1.5.4
References: <200309281502.38370.cijoml@volny.cz> <20030929101453.18c804dd.rddunlap@osdl.org>
In-Reply-To: <20030929101453.18c804dd.rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309291930.57987.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I call simply "modprobe 3c59x" as always.
In all previous kernels before 2.6.0-test6 it worked (2.4,2.2)

/etc/modprobe.conf
alias eth0 3c59x
options 3c59x 3c509x debug=0 options=4,8

It's generated from /etc/modules.conf in 2.4
alias eth0 3c59x
options 3c59x 3c509x debug=0 options=4,8

And looks the same

Info about card from 2.4.22:

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
01:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xcc00. Vers LK1.1.18-ac
 00:50:04:6a:58:cd, IRQ 10
  product code 544e rev 00.9 date 02-17-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
01:0a.0: scatter/gather enabled. h/w checksums enabled

Michal 

Dne po 29. zברם 2003 19:14 jste napsal(a):
> On Sun, 28 Sep 2003 15:02:38 +0200 "Michal Semler (volny.cz)" 
<cijoml@volny.cz> wrote:
> | Hi,
> |
> | I compiled 2.6.0-test6, but my ethernet card doesn't work:
> |
> | modprobe 3c59x tells this:
> | Sep 28 10:06:58 tata kernel: 3c59x: Unknown parameter `3c509x'
>
> So 3c59x complains about '3c509x' ??
>
> Did you use any module parameters, either on the modprobe command
> or in the /etc/modprobe.conf file?
>
> --
> ~Randy

