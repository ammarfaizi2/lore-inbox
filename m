Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWGITlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWGITlE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWGITlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:41:03 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:30938 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1161085AbWGITlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:41:01 -0400
Message-ID: <44B15BCB.5000306@vc.cvut.cz>
Date: Sun, 09 Jul 2006 21:40:59 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Revert "ACPI: dock driver"
References: <200607091559.k69Fx2h0029447@hera.kernel.org>
In-Reply-To: <200607091559.k69Fx2h0029447@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 953969ddf5b049361ed1e8471cc43dc4134d2a6f
> tree e4b84effa78a7e34d516142ee8ad1441906e33de
> parent b862f3b099f3ea672c7438c0b282ce8201d39dfc
> author Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 -0700
> 
> Revert "ACPI: dock driver"
> 
> This reverts commit a5e1b94008f2a96abf4a0c0371a55a56b320c13e.
> 
> Adrian Bunk points out that it has build errors, and apparently no
> maintenance. Throw it out.

Erm, what do I miss?  Code certainly builds, just before that checkin.

ppc:~$ ls -la /usr/src/linus/linux-2.6.18-rc1-b862/drivers/acpi/dock*
-rw-r--r-- 1 root root  19474 Jul  9 17:04 
/usr/src/linus/linux-2.6.18-rc1-b862/drivers/acpi/dock.c
-rw-r--r-- 1 root root 148519 Jul  9 17:33 
/usr/src/linus/linux-2.6.18-rc1-b862/drivers/acpi/dock.o
ppc:~$ uname -a
Linux ppc 2.6.18-rc1-b862 #1 SMP PREEMPT Sun Jul 9 17:53:48 CEST 2006 x86_64 
GNU/Linux
ppc:~$

						Thanks,
							Petr Vandrovec

