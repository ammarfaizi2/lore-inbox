Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTIMIvR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 04:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTIMIvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 04:51:17 -0400
Received: from webmail.netregistry.net ([203.202.16.21]:53374 "EHLO
	webmail.netregistry.net") by vger.kernel.org with ESMTP
	id S262086AbTIMIvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 04:51:16 -0400
Message-ID: <1063443074.3f62da82a7e24@webmail.netregistry.net>
Date: Sat, 13 Sep 2003 18:51:14 +1000
From: Dmitri Katchalov <dmitrik@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 atkbd.c: Unknown key (100% reproduceable)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 144.132.160.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[My first post didn't make to the list. Apologies if it appears twice]

Hi,

I'm consistently getting this error:

atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0) pressed.
This happens whenever I type 'f' in "<F7>usbdevfs". It then keeps 
repeating the 'f' until I press another key. I first noticed it when 
doing a search in mcedit but it also happens on command line and 
everywhere. It does not matter if I type it slow of fast. If I type 
less then the whole string (eg. "devf") the error does not occur but 
the letter 'f' occasionally gets eaten away.

H/W: P4 (w/HT), ABIT IS7 M/B with Intel i865/ICH5 chipset, 
bog-standard cheap PS/2 kbd.
S/W: Debian mid-way between stable and testing, 2.6.0-test5 
with SMP and preemptive, no extra tasks running (I can reproduce it at 
the login prompt immediately after reboot).

I'll be happy to investigate it further if someone tells me what to do.

Regards,
Dmitri



