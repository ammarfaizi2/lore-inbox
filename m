Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUIBTjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUIBTjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268430AbUIBTjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:39:16 -0400
Received: from giesskaennchen.de ([83.151.18.118]:52395 "EHLO
	mail.uni-matrix.com") by vger.kernel.org with ESMTP id S268421AbUIBTjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:39:02 -0400
Message-ID: <41377705.9060305@giesskaennchen.de>
Date: Thu, 02 Sep 2004 21:39:49 +0200
From: Oliver Antwerpen <olli@giesskaennchen.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel Build error (objdump fails)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-giesskaennchen.de-MailScanner-Information: Die Giesskaennchen verschicken keine Viren!
X-giesskaennchen.de-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

when compiling the linux kernel (I tried 2.6.8, 2.6.8.1, 2.6.9-rc1) I get:

   CC      arch/i386/kernel/acpi/sleep.o
   AS      arch/i386/kernel/acpi/wakeup.o
   LD      arch/i386/kernel/acpi/built-in.o
arch/i386/kernel/acpi/boot.o: file not recognized: File truncated
make[2]: *** [arch/i386/kernel/acpi/built-in.o] Error 1
make[1]: *** [arch/i386/kernel/acpi] Error 2
make: *** [arch/i386/kernel] Error 2

c80:/tmp# gcc --version
gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)
c80:/tmp# objdump -v
GNU objdump 2.14.90.0.7 20031029 Debian GNU/Linux
c80:/tmp# make -v
GNU Make 3.80

Which information do you need? Where shall I start?

Ollfried


