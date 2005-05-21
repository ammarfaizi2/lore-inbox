Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVEUPYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVEUPYS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 11:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEUPYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 11:24:18 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:29966 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261716AbVEUPYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 11:24:14 -0400
Message-ID: <428F52A2.4060905@rainbow-software.org>
Date: Sat, 21 May 2005 17:24:18 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregor Jasny <gjasny@web.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: What happened to Cyrix 6x86 support in 2.6?
References: <200505211625.56664.gjasny@web.de>
In-Reply-To: <200505211625.56664.gjasny@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Jasny wrote:
> Hi,
> 
> I have an old machine with a Cyrix 6x86 processor. When running Linux 2.4 it is recognized as a Cyrix and MTRR is enabled:
> 
> kernel: Linux version 2.4.22 (root@Rincewind) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Fri Nov 28 15:43:13 CET 2003
> ...
> kernel: Enabling CPUID on Cyrix processor.
> kernel: CPU:     After generic, caps: 00000105 00000000 00000000 00000004
> kernel: CPU:             Common caps: 00000105 00000000 00000000 00000004
> kernel: CPU: Cyrix 6x86L 2x Core/Bus Clock stepping 02
> 
> But when I boot a Linux 2.6 kernel with CONFIG_M586=y it recognizes only a 486.

Something like that also happened with my UMC 486. It's now detected as:

Linux version 2.6.8.1-router (root@pentium) (gcc version 3.3.4) #1 Thu 
Sep 9 12:42:25 CEST 2004
...
CPU: After generic identify, caps: 00000000 00000000 00000000 00000000
CPU: After all inits, caps:        00000000 00000000 00000000 00000000
CPU: UMC UMC UMC  ff/02 stepping 03

It used to be detected more nicely in 2.4.x (I don't remember exact string).

-- 
Ondrej Zary
