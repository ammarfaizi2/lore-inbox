Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131801AbRCOTgn>; Thu, 15 Mar 2001 14:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131805AbRCOTgf>; Thu, 15 Mar 2001 14:36:35 -0500
Received: from [142.176.139.106] ([142.176.139.106]:32772 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S131801AbRCOTgT>;
	Thu, 15 Mar 2001 14:36:19 -0500
Date: Thu, 15 Mar 2001 15:35:01 -0400 (AST)
From: Ted Gervais <ve1drg@ve1drg.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.2
Message-ID: <Pine.LNX.4.21.0103151527420.2382-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A simple question for you guru's..

I just installed kernel 2.4.2 on a slackware system and have a problem 
with loading a module. It is the 8139too.o module previously the
rtl8139.o.   It seems that this new driver is not being loaded with
this new kernel. Obviously something has changed but I can't seem to see 
where that is.  I noticed though that the directories in /lib/modules for
this kernel is different than 2.2.18.  

Anyways - to get things to work, I have put added this statement to the
top of my /etc/rc.d/rc.inet1 file:

insmod /usr/src/linux/drivers/net/8139too.o.

That seems to get things working but why should I do that.

By the way - I do have  'alias eth0 8139too.o'  in my /etc/modules.conf
file.

Any thoughts on where I might be going wrong. And I do have
'CONFIG_KMOD=y' in my kernel configuration..

---
Earth is a beta site. 
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


