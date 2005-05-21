Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVEUUXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEUUXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVEUUXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 16:23:31 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:35235 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261557AbVEUUX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 16:23:27 -0400
Message-ID: <428F98BE.6070700@tiscali.de>
Date: Sat, 21 May 2005 22:23:26 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
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
> 
> Can somebody explain this behavior? Was support for Cyrix 6x86 dropped?
> 
> Cheers,
> Gregor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
An hafl hour ago my cyrix with 150 Mhz was runnig very good with Fedora 4 Test 1.

Matthias-Christian Ott
