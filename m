Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVKXOLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVKXOLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVKXOLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:11:36 -0500
Received: from mail.tataelxsi.co.in ([203.200.1.48]:61229 "EHLO
	mail.tataelxsi.co.in") by vger.kernel.org with ESMTP
	id S1751023AbVKXOLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:11:36 -0500
Message-ID: <4385CA66.8060709@tataelxsi.co.in>
Date: Thu, 24 Nov 2005 19:42:54 +0530
From: Satyaki Mukherjee <satyaki@tataelxsi.co.in>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Compiling Linux kernel 2.6.13.2 for Xtensa
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Mirapoint-Sig: mail.tataelxsi.co.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am facing problems while compiling the Linux kernel(version 2.6.13.2) 
for XTENSA. I am using xtensa-elf- toolchain of following versions -
binutils - 2.12.1
gcc - 3.0.4
The toolchain was built from the sources as per the instruction given 
with the patches that came along with XTENSA configuration
The configuration used for kernel compilation is --- 
arch/xtensa/configs/iss_defconfig.

The compilation seems to go fine except towards the end where I get the 
following error during linking ---

  LD      init/built-in.o
    LD      .tmp_vmlinux1
    arch/xtensa/kernel/built-in.o: In function `__down':
    arch/xtensa/kernel/built-in.o(.sched.text+0x11):dangerous 
relocation: l32r: literal placed after use: .sched.text.literal
    arch/xtensa/kernel/built-in.o(.sched.text+0x23):dangerous 
relocation: l32r: literal placed after use: .sched.text.literal
    arch/xtensa/kernel/built-in.o(.sched.text+0x5b):dangerous 
relocation: l32r: literal placed after use: .sched.text.literal
    arch/xtensa/kernel/built-in.o: In function `__down_interruptible':
    arch/xtensa/kernel/built-in.o(.sched.text+0x71):dangerous 
relocation: l32r: literal placed after use: .sched.text.literal
    arch/xtensa/kernel/built-in.o(.sched.text+0x89):dangerous 
relocation: l32r: literal placed after use: .sched.text.literal
    arch/xtensa/kernel/built-in.o(.sched.text+0xf3):dangerous 
relocation: l32r: literal placed after use: .sched.text.literal
    kernel/built-in.o: In function `schedule':
    kernel/built-in.o(.sched.text+0x1f):dangerous relocation: l32r: 
literal placed after use: .sched.text.literal
    kernel/built-in.o(.sched.text+0x31):dangerous relocation: l32r: 
literal placed after use: .sched.text.literal
....... many more such messages follow

Would be greatful if somebody could provide information in this regard

Regards
Satyaki Mukherjee

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s)and may contain confidential or privileged information. If you are not the intended recipient, please notify the sender or administrator@tataelxsi.co.in
