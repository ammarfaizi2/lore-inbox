Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbTGDKEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbTGDKEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:04:20 -0400
Received: from home.wiggy.net ([213.84.101.140]:39555 "EHLO
	tornado.home.wiggy.net") by vger.kernel.org with ESMTP
	id S265960AbTGDKEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:04:16 -0400
Date: Fri, 4 Jul 2003 12:18:44 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704101844.GC2159@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net> <20030704102018.A4374@flint.arm.linux.org.uk> <20030704093732.GA2159@wiggy.net> <20030704105826.D4374@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704105826.D4374@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Russell King wrote:
> Out of interest, can you send me your /proc/ioports please?  Thanks.

Certainly:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
1400-14ff : PCI CardBus #03
1800-18ff : PCI CardBus #07
1c00-1cff : PCI CardBus #07
b080-b0ff : Intel Corp. 82801DB AC'97 Modem
b400-b4ff : Intel Corp. 82801DB AC'97 Modem
b800-b8ff : Intel Corp. 82801DB AC'97 Audio
bc40-bc7f : Intel Corp. 82801DB AC'97 Audio
bf20-bf3f : Intel Corp. 82801DB USB (Hub #3)
bf40-bf5f : Intel Corp. 82801DB USB (Hub #2)
bf80-bf9f : Intel Corp. 82801DB USB (Hub #1)
bfa0-bfaf : PCI device 8086:24ca (Intel Corp.)
  bfa0-bfa7 : ide0
  bfa8-bfaf : ide1
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Radeon R250 Lf [Rade

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

