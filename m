Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315827AbSEEHYf>; Sun, 5 May 2002 03:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315828AbSEEHYe>; Sun, 5 May 2002 03:24:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31877 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315827AbSEEHYd>;
	Sun, 5 May 2002 03:24:33 -0400
Date: Sun, 05 May 2002 00:11:58 -0700 (PDT)
Message-Id: <20020505.001158.128654145.davem@redhat.com>
To: flo@rfc822.org
Cc: ivan@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64 cleanup cyclades.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020504162518.GA7785@paradigm.rfc822.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Florian Lohoff <flo@rfc822.org>
   Date: Sat, 4 May 2002 18:25:18 +0200

   @@ -4895,7 +4895,7 @@
                    }
    
                    /* allocate IRQ */
   -                if(request_irq(cy_isa_irq, cyy_interrupt,
   +                if(request_irq(cy_isa_irq, &cyy_interrupt,
    				   SA_INTERRUPT, "Cyclom-Y", &cy_card[j]))
                    {
                            printk("Cyclom-Y/ISA found at 0x%lx ",

This looks suspicious, did you really need it?
