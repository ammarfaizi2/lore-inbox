Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTEKAXC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 20:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTEKAXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 20:23:02 -0400
Received: from [211.167.76.68] ([211.167.76.68]:60388 "HELO soulinfo")
	by vger.kernel.org with SMTP id S264535AbTEKAXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 20:23:01 -0400
Date: Sun, 11 May 2003 08:28:59 +0800
From: hugang <hugang@soulinfo.com>
To: tom@qwws.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.96] SWSUSP - resume fails
Message-Id: <20030511082859.269dda4f.hugang@soulinfo.com>
In-Reply-To: <200305102254.05895.tom@qwws.net>
References: <200305102254.05895.tom@qwws.net>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= tom@qwws.net
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 22:54:05 +0200
Tom Winkler <tom@qwws.net> (by way of Tom Winkler <tom@qwws.net>) wrote:

>  Trace; c024a243 <eepro100_resume+d3/100>
>  Trace; c01ea6d6 <pci_pm_resume_device+26/30>
>  Trace; c01ea80b <pci_pm_resume_bus+2b/70>
>  Trace; c01ea838 <pci_pm_resume_bus+58/70>
>  Trace; c01ea953 <pci_pm_resume+33/50>
>  Trace; c01ea9b5 <pci_pm_callback+45/50>
>  Trace; c022605b <agp_power+1b/30>
>  Trace; c012eb81 <pm_send+71/a0>

Try this
1) before resume run ifconfig eth0 down; modprobe -r eepro100;
2) after resume run modprobe eepro100; ifconfig eth0 up;


-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
