Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280254AbRKIW1M>; Fri, 9 Nov 2001 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280238AbRKIW1C>; Fri, 9 Nov 2001 17:27:02 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:37787 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S280251AbRKIW0v>; Fri, 9 Nov 2001 17:26:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Martin Fischer <martin.fischer@netsurf.de>
To: linux-kernel@vger.kernel.org
Subject: outcommand error 2
Date: Fri, 9 Nov 2001 23:23:44 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011109222654Z280251-17408+12782@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone please help me to understand
the following error messages. They messages 
appeared after upgrading from 256 to 512 MB RAM.

The first boot with the new RAM modules failed.
the system stopped completely, only the "shift lock" 
and "scroll lock" LED where blinking. 

A second boot was fine. I tried a kernel compile
for memory testing :-) and everything seems to
be ok.

But now I get the following messages:

Nov  9 22:47:59 linux kernel: outcommand error 2
Nov  9 22:47:59 linux kernel: commandrequest error
Nov  9 22:47:59 linux kernel: dvb0: ARM crashed!
Nov  9 22:47:59 linux kernel: outcommand error 2
Nov  9 22:47:59 linux kernel: commandrequest error
Nov  9 23:03:49 linux kernel: dvb: 1 dvb(s) released.
Nov  9 23:03:49 linux kernel: free irqs

I looked into the kernel sources but I could 
not even find the word "commandrequest". The
errors happened while loading DVB drivers. 

I'm running a 2.4.10-ac12 kernel on a pentium III
with 512MB RAM.

Some ideas?

thanks, Martin
