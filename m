Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRJUBuS>; Sat, 20 Oct 2001 21:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJUBuI>; Sat, 20 Oct 2001 21:50:08 -0400
Received: from mail010.mail.bellsouth.net ([205.152.58.30]:65325 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S275110AbRJUBuD>; Sat, 20 Oct 2001 21:50:03 -0400
Message-ID: <3BD229FC.7A33A7A9@mandrakesoft.com>
Date: Sat, 20 Oct 2001 21:50:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compile error with -pre5 (i2o & pdev)
In-Reply-To: <3BD211A7.DFD4AD9C@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c i2o_pci.c
> i2o_pci.c: In function `i2o_pci_install':
> i2o_pci.c:165: structure has no member named `pdev'

Re-post :)

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.13/i2o-build-2.4.13.5.patch.gz

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

