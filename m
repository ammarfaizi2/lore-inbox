Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRC3KCj>; Fri, 30 Mar 2001 05:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRC3KCa>; Fri, 30 Mar 2001 05:02:30 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:28758 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131270AbRC3KCL>; Fri, 30 Mar 2001 05:02:11 -0500
Date: Fri, 30 Mar 2001 04:01:27 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: George Bonser <george@gator.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 aic7xxx wont compile
In-Reply-To: <CHEKKPICCNOGICGMDODJOEHOCJAA.george@gator.com>
Message-ID: <Pine.LNX.3.96.1010330040106.8826I-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, George Bonser wrote:

> Just tried to build 2.4.3, got:
> 
> make[6]: Entering directory
> `/usr/local/src/linux/drivers/scsi/aic7xxx/aicasm'
> gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
> aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
> aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
> aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
> aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
> aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
> aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
> aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory

Looks like the gcc command line needs '-I.' there...

	Jeff



