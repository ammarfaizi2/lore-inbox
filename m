Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVLPNeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVLPNeF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVLPNeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:34:05 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:25481 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S932253AbVLPNeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:34:04 -0500
Date: Fri, 16 Dec 2005 08:33:48 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.14.4 sparc compile problem
Message-ID: <Pine.LNX.4.64.0512160832350.995@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I tried to compile kernel 2.6.14.4 on my sparc and I got this:

drivers/built-in.o(.init.text+0x1184): In function `rtc_init':
: undefined reference to `ebus_chain'
drivers/built-in.o(.init.text+0x1188): In function `rtc_init':
: undefined reference to `ebus_chain'
drivers/built-in.o(.init.text+0x1190): In function `rtc_init':
: undefined reference to `isa_chain'
drivers/built-in.o(.init.text+0x11d4): In function `rtc_init':
: undefined reference to `isa_chain'
drivers/built-in.o(.init.text+0x11d8): In function `rtc_init':
: undefined reference to `isa_chain'
make: *** [.tmp_vmlinux1] Error 1


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
