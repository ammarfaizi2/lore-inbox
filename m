Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbRFWXwM>; Sat, 23 Jun 2001 19:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbRFWXwB>; Sat, 23 Jun 2001 19:52:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27923 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264690AbRFWXvx>; Sat, 23 Jun 2001 19:51:53 -0400
Subject: Re: GCC3.0 support: Kernel 2.4.5 compilation troubles
To: dmor@7ka.mipt.ru (Alexander V. Bilichenko)
Date: Sun, 24 Jun 2001 00:51:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c0fc3e$b13498c0$d55355c2@microsoft> from "Alexander V. Bilichenko" at Jun 24, 2001 03:46:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DxBM-0005zf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello all!
> trying to compile kernel I got following:

Use 2.95 or 2.96 not gcc 3.0 if you want a peaceful time of it. If you are
feeling bold and adventurous then 

1.	Get 2.4.6pre5 - this has the compile bug you see fixed (older gcc 
	just missed seeing/reporting it)

2.	Look back in the kernel archives and you'll find some patches for
	the warnings about multi-line string literals in asm blocks
