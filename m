Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbRGCKeA>; Tue, 3 Jul 2001 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRGCKdu>; Tue, 3 Jul 2001 06:33:50 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9381 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S263906AbRGCKdn>; Tue, 3 Jul 2001 06:33:43 -0400
Date: Tue, 3 Jul 2001 16:09:36 +0530 (IST)
From: Balbir Singh <balbir.singh@wipro.com>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reg kdb utility
In-Reply-To: <Pine.LNX.4.10.10107031311370.6784-100000@blrmail>
Message-ID: <Pine.SV4.4.21.0107031608230.24672-100000@wipro.wipsys.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to compile with the correct  kernel headers using the include
path feature -I <path to new headers>

Balbir



On Tue, 3 Jul 2001, SATHISH.J wrote:

|Hi,
|
|I tried to use kdb on my 2.2.14-12 kernel. I was able to compile the file 
|/usr/src/linux/arch/i386/kdb/modules/kdbm_vm.c and could get the object
|file. When I tried to insert it as a module it givesd the following error
|message:
|
|./kdbm_vm.o: kernel-module version mismatch
|        ./kdbm_vm.o was compiled for kernel version .2.14-12
|        while this kernel is version 2.2.14-12.
|
|
|
|Please tell me why this message comes.
|
|Thanks in advance,
|
|Regards,
|satish.j
|
|
|
|
|
|
|
|
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/
|

