Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbREZGxI>; Sat, 26 May 2001 02:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbREZGw6>; Sat, 26 May 2001 02:52:58 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:46348 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262611AbREZGwv>; Sat, 26 May 2001 02:52:51 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200105260109.DAA02469@kufel.dom>
Subject: Re: [PATCH] __init -> __initdata in drivers/video/matrox/matroxfb_base.c (244ac16)
To: kufel!jaquet.dk!rasmus@green.mif.pg.gda.pl (Rasmus Andersen)
Date: Sat, 26 May 2001 03:09:51 +0200 (CEST)
Cc: kufel!vc.cvut.cz!vandrove@green.mif.pg.gda.pl,
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <20010525231122.N851@jaquet.dk> from "Rasmus Andersen" at maj 25, 2001 11:11:22 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-244-ac11-clean/drivers/video/matrox/matroxfb_base.c	Sat May 19 20:58:43 2001
> +++ linux-244-ac11/drivers/video/matrox/matroxfb_base.c	Sun May 20 23:55:24 2001
> @@ -2483,7 +2483,7 @@
>  	return 0;
>  }
>  
> -static int __init initialized = 0;
> +static int __initdata initialized = 0;

It should be 

static int initialized __initdata = 0;

Andrzej

