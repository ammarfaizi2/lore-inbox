Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132710AbRDQXAr>; Tue, 17 Apr 2001 19:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132722AbRDQXAi>; Tue, 17 Apr 2001 19:00:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132710AbRDQXAY>; Tue, 17 Apr 2001 19:00:24 -0400
Subject: Re: 2.4.3-ac8 build error with CONFIG_DEBUG_KERNEL not set
To: scole@lanl.gov
Date: Wed, 18 Apr 2001 00:02:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        elenstev@mesatop.com
In-Reply-To: <01041716371704.01250@spc2.esa.lanl.gov> from "Steven Cole" at Apr 17, 2001 04:37:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14peUM-0003UE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel/kernel.o(__ksymtab+0xca0): undefined reference to `__sysrq_get_key_op'
> kernel/kernel.o(__ksymtab+0xca8): undefined reference to `__sysrq_put_key_op'
> make: *** [vmlinux] Error 1
> 
> However, with CONFIG_DEBUG_KERNEL and CONFIG_MAGIC_SYSRQ set to y,
> I got a clean build. 

ac8 has a few build glitches. Im testing ac9 now mostly to squash them before
everyone mails me 8)
