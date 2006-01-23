Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWAWFFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWAWFFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWAWFFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:05:18 -0500
Received: from xenotime.net ([66.160.160.81]:958 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964782AbWAWFFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:05:17 -0500
Date: Sun, 22 Jan 2006 21:05:24 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: menuconfig elements unaligned
Message-Id: <20060122210524.2f25d0e5.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006 21:20:11 +0100 (MET) Jan Engelhardt wrote:

> Hi,
> 
> 
> in Drivers > Network > 10 or 100Mbit, this shows up:
> 
>  [*] EISA, VLB, PCI and on board controllers
>  < >   AMD PCnet32 PCI support
>  < >   AMD 8111 (new PCI lance) support
>  < >   Adaptec Starfire/DuraLAN support
>  < >   Broadcom 4400 ethernet support (EXPERIMENTAL)
>  < >   Reverse Engineered nForce Ethernet support (EXPERIMENTAL)
>  < > Digi Intl. RightSwitch SE-X support
>  < > EtherExpressPro/100 support (eepro100, original Becker driver)
>  < > Intel(R) PRO/100+ support
> 
> Deactivating EISA would suggest that Digi Intl. and everything below would
> remain visible, but they do not. If someone got the time to, please fix it.
> Thanks.

Like Sam replied, I don't see a problem.  But the indentation shown
above isn't how I see it on-screen.  The Digi, EtherExpressPro/100,
and Intel(R) PRO/100+ are all indented under EISA/VLB/PCI for me.


However, here's another one.  On ARCH=i386, the top-level menu shows
[ ] Enable doublefault exception handler

(menuconfig or xconfig)
This is from arch/i386/Kconfig (line 50).  Surely this should be
under "Processor type and features" or some other menu, not at the
top level.

---
~Randy
