Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUAXA6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUAXA6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:58:53 -0500
Received: from mail.bluebottle.com ([69.20.6.25]:61829 "EHLO
	www.bluebottle.com") by vger.kernel.org with ESMTP id S266846AbUAXA6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:58:02 -0500
Date: Fri, 23 Jan 2004 22:57:44 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus
To: linux-kernel@vger.kernel.org
Subject: IO-APIC works on Windows and FreeBSD but not Linux ?
Message-ID: <20040123222512.J72816@pervalidus>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never got IO-APIC to work with my ECS K7VTA3 5.0 (KT333) on
Linux 2.4 and 2.6. The first problem was at boot time with my
network. It wouldn't give an IRQ or something to the lan, be it
the onboard Realtek or a 3Com 3C905CX-TXNM.

ACPI with or without it was even worse, but I never needed it.
It worked fine on Windows XP Professional SP1. Some days ago I
installed FreeBSD 5.2 and now noticed it gave me IRQ18 for the
onboard lan, IRQ22 for the onboard sound, and so on, and
there's the following in /var/log/messages:

Jan 23 15:27:07 pervalidus kernel: ioapic0: Assuming intbase of 0
Jan 23 15:27:07 pervalidus kernel: ioapic0 <Version 0.3> irqs 0-23 on motherboard

I'm just surprised IO-APIC works with it but not Linux.

I reported it months ago -
http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.2/1646.html

BTW, the freezes I mentioned are gone. The motherboard may be a
bit buggy, as they appear if I disable the onboard RAID, but...

-- 
http://www.pervalidus.net/contact.html
