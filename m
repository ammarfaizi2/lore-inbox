Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVGLSIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVGLSIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVGLSIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:08:48 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:33186 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP id S261854AbVGLSIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:08:47 -0400
Date: Tue, 12 Jul 2005 20:08:44 +0200 (CEST)
From: Tomasz Lemiech <szpajder@staszic.waw.pl>
To: torvalds@osdl.org
cc: chrisw@osdl.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: 2.6.12.2 acpi_register_gsi() patch causes problems on Asus A7V333
 motherboard
Message-ID: <Pine.LNX.4.63.0507121940170.11987@boss.staszic.waw.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Today I tried 2.6.12.2 on an Asus A7V333 (socket A) with AMD Duron 1300 
MHz CPU and noticed, that the system clock was running about 60 times 
faster than real time and the keyboard was unresponsive. However, I was 
able to log in remotely and collect some standard debugging info (dmesg, 
lspci, interrupts, config), which is available at 
http://szpajder.w.staszic.waw.pl/a7v333/ . Summary of my quick research 
follows:

- 2.6.12.1 works without problems

- 2.6.12.2 with acpi=off works without problems

- 2.6.12.2 with acpi_register_gsi() one-line fix works without problems

I was using Asus BIOS revision 1012 and also tried to upgrade to the 
latest 1017 with no luck.

Please Cc: any replies, because I'm not subscribed to the list. Thanks.

Regards,

-- 
 			     	 Tomasz Lemiech (RLU#189399) (TL4681-RIPE)
 				  <szpajder@staszic.waw.pl> [GG:3786250]
