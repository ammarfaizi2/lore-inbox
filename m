Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUISVHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUISVHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUISVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:07:04 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:13722 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S263893AbUISVHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:07:01 -0400
From: David Sanders <linux@sandersweb.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Kernel Panic, Fedora Core 2, Virtual PC
Date: Sun, 19 Sep 2004 17:07:03 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409191707.04177.linux@sandersweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to install Fedora Core 2 on Virtual PC (using Dell Dimension 4600 with 
2.8 GHz with HT, 1 GB or RAM.) it crashes right after typing 'linux text'.
 
 Here is what's left on the screen:
 
 apm: overridden by ACPI.
 audit: initializing netlink socket (disabled)
 audit(1093558315.547:0): initialized
 Total HugeTLB memory allocated, 0
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 SELinux:  Registering netfilter hooks
 invalid operand: 0000 [#1]
 CPU:    0
  
 EIP:    0060:[<c01040c2>]    Not tainted
 EFLAGS: 00000286   (2.6.5-1.358)
 EIP is at mwait_idle+0x23/0x40
 eax: c031f008   ebx: c031f000   ecx: 00000000   edx: 00000000
 esi: 00039100   edi: c034e7a0   ebp: 003b2007   esp: c031ffec
 ds: 007b   es: 007b   ss: 0068
 Process swapper (pid: 0, threadinfo=c031f000 task=c02cdaa0)
 Stack: 00020800 c010408a c03205fe c034e7c0 c010019f
 Call Trace:
     
  [<c010408a>] cpu_idle+0x1d/0x32
  [<c03205fe>] start_kernel+0x174/0x176
                                                              
          
 Code: 0f 01 c8 8b 43 08 a8 08 75 0c 89 c8 0f 01 c9 8b 43 08 a8 08
  <0>Kernel panic: Attempted to kill the idle task!
 In idle task - not syncing


What to do?
