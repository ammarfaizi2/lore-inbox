Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262231AbRERB4k>; Thu, 17 May 2001 21:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262232AbRERB4U>; Thu, 17 May 2001 21:56:20 -0400
Received: from [142.176.139.106] ([142.176.139.106]:39433 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S262231AbRERB4J>;
	Thu, 17 May 2001 21:56:09 -0400
Date: Thu, 17 May 2001 22:56:07 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: linux-kernel@vger.kernel.org
Subject: rtl8139 - kernel 2.4.3
Message-ID: <Pine.LNX.4.21.0105172254060.7428-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get the following when ftping from one workstation to another.
Using kernel 2.4.3 and Redhat7.1:

Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
eth0: Out-of-sync dirty pointer, 456 vs. 462.
Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677


Is there a fix for this?  Kernel 2.4.4 is worse. It gives me a 'kernel
panic'..  doing the same ftp transfer between workstations.

---
The mosquito is the state bird of New Jersey.
                -- Andy Warhol
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


