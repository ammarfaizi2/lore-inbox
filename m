Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTKIPsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTKIPsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:48:55 -0500
Received: from [202.54.110.230] ([202.54.110.230]:55431 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S262598AbTKIPsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:48:53 -0500
Message-ID: <1B3885BC15C7024C845AAC78314766C5A26687@EXCH-01>
From: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
To: alex_williamson@hp.com, arjanv@redhat.com, eranian@hpl.hp.com
Cc: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: problem in booting HP zx6000 with stock kernel 2.5.75
Date: Sun, 9 Nov 2003 21:18:28 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody

I am trying to boot 2 CPU hp zx6000 machine (ia64, itanium2) from STOCK
kernel version 2.5.75. I have followed following steps.

1. I have downloaded the kernel from www.kernel.org . Also I have applied
ia64 patch (from
http://www.kernel.org/pub/linux/kernel/ports/ia64/v2.5/linux-2.5.75-ia64-030
712.diff.gz) on it  .

2. Now I have build the kernel (using make compressed) for ia64 processor
type hp-zx1. (With ia64 processor type "generic" I got errors on compilation
like NR_NODES are not declared.. etc.). 

3. I have copied vmlinuz.gz (using mcopy) to vfat mounted partition
(/boot/efi/efi/redhat) and made appropriate entries in elilo.conf. 

4. Now I have rebooted the system and tried to load the image using EFI
shell.

5. The kernel hangs after uncompressing the kernel successfully. Nothing is
working here, neither keyboard nor anything else.

Kindly provide me appropriate guidance.. , where am I wrong ?

I have following doubts: -

1. Is it possible to build and run _stock_ kernel (not redhat patched
kernel, as redhat advanced distribution is available on my machine) on hp
zx6000 machine ? Do I need additional patches the stock kernel + ia64 patch
?

PLEASE CC REPLY TO ME ALSO..

Thanks in advance..

Deepak Kumar Gupta
HCL Technologies Limited
NOIDA, UP
INDIA.

 
