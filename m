Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289495AbSAOK7e>; Tue, 15 Jan 2002 05:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289496AbSAOK7Z>; Tue, 15 Jan 2002 05:59:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12705 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289495AbSAOK7L>;
	Tue, 15 Jan 2002 05:59:11 -0500
Date: Tue, 15 Jan 2002 02:57:41 -0800 (PST)
Message-Id: <20020115.025741.73663681.davem@redhat.com>
To: tyketto@wizard.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: atyfb in 2.5.2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020115094953.GA24170@wizard.com>
In-Reply-To: <20020115094953.GA24170@wizard.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: A Guy Called Tyketto <tyketto@wizard.com>
   Date: Tue, 15 Jan 2002 01:49:53 -0800

   make[4]: Entering directory `/usr/src/linux/drivers/video/aty'
   gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
   -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
   -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     
   -DEXPORT_SYMTAB -c atyfb_base.c
   atyfb_base.c: In function `aty_init':
   atyfb_base.c:1989: incompatible types in assignment

Replace the "-1" on that line with "NODEV".
