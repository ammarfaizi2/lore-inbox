Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTJ2L4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 06:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTJ2L4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 06:56:12 -0500
Received: from mail01.mail.esat.net ([193.120.142.6]:35273 "EHLO
	mail01.mail.esat.net") by vger.kernel.org with ESMTP
	id S261996AbTJ2L4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 06:56:11 -0500
Message-ID: <07a801c39e13$a4d1dc90$6e69690a@RIMAS>
From: "Remus" <rmocius@auste.elnet.lt>
To: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <1067351431.1358.11.camel@teapot.felipe-alfaro.com> <20031028172818.GB2307@elf.ucw.cz> <1067372182.864.11.camel@teapot.felipe-alfaro.com> <20031029093802.GA757@elf.ucw.cz> <20031029112824.GA7789@iram.es>
Subject: PCI Bus error 6290 or 0290
Date: Wed, 29 Oct 2003 11:55:39 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have installed the latest 2.6.0-test9 kernel and I get this error
messages:
Oct 29 13:51:39 fw kernel: eth1: PCI Bus error 6290.
Oct 29 13:51:39 fw kernel: eth1: PCI Bus error 0290.

The problem is with Realtek (RTL-8139) network card drivers.

root@fw:~# lspci -v
00:05.0 Host bridge: Silicon Integrated Systems [SiS] 85C496 (rev 31)
        Flags: bus master, medium devsel, latency 0

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Edimax Computer Co.: Unknown device 9503
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at fc00 [size=256]
        Memory at ffbeff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:0f.0 Ethernet controller: Compex ReadyLink 2000 (rev 0a)
        Flags: medium devsel, IRQ 7
        I/O ports at ff80 [size=32]
        Expansion ROM at ffbe0000 [disabled] [size=32K]

Any ideas/solutions?

Thanks in advance

Remus


