Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291591AbSBMLi6>; Wed, 13 Feb 2002 06:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291597AbSBMLis>; Wed, 13 Feb 2002 06:38:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7042 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291591AbSBMLib>;
	Wed, 13 Feb 2002 06:38:31 -0500
Date: Wed, 13 Feb 2002 03:36:41 -0800 (PST)
Message-Id: <20020213.033641.102576462.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, ralf@uni-koblenz.de
Subject: Re: [patch] printk and dma_addr_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16awZq-0004s4-00@the-village.bc.nu>
In-Reply-To: <20020213.013557.74564240.davem@redhat.com>
	<E16awZq-0004s4-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Wed, 13 Feb 2002 10:23:50 +0000 (GMT)
   
   So how do they modify the printf format rules in gcc ?
   
Because they can claim that they are part of the C environment, and
for the most part they are right so their extensions go into gcc's
magic list.

In fact I'd claim their case to be plugging holes in the standards
specified set of printf format strings. :-)

Hey... we could "borrow" one of these printf format strings we
don't have any need for in the kernel and pretend that is for
"dma_addr_t". :-)
