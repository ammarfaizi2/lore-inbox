Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTDQAl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDQAl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:41:56 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:34862 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261994AbTDQAl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:41:56 -0400
Date: Wed, 16 Apr 2003 21:53:21 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: CONFIG_X86_UP_APIC and CONFIG_X86_UP_IOAPIC won't allow me
 to connect with my ADSL
Message-ID: <Pine.LNX.4.53.0304162132200.173@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed an ECS K7VTA3 5.0 and ADSL. I was using an
ASUS A7S333 and cable modem.

With a kernel compiled with CONFIG_X86_UP_APIC and
CONFIG_X86_UP_IOAPIC adsl-start will timeout. adsl-connect also
fails.

There's a " WARNING: unexpected IO-APIC, please mail to
linux-smp@vger.kernel.org" in dmesg.

With a kernel compiled without CONFIG_X86_UP_APIC and
CONFIG_X86_UP_IOAPIC I can succesfully establish a connection.

My APIC disabled .config is available at
http://www.fredlwm.hpg.com.br/.config-2.4.20-NOAPIC

My APIC disabled dmesg available at
http://www.fredlwm.hpg.com.br/dmesg-2.4.20-NOAPIC

My APIC enabled dmesg is available at
http://www.fredlwm.hpg.com.br/dmesg-2.4.20-APIC
