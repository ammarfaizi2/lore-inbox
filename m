Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264002AbRFPQRq>; Sat, 16 Jun 2001 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbRFPQRh>; Sat, 16 Jun 2001 12:17:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28631 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264002AbRFPQRZ>;
	Sat, 16 Jun 2001 12:17:25 -0400
Message-ID: <3B2B8676.7FAD5135@mandrakesoft.com>
Date: Sat, 16 Jun 2001 12:16:54 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Dickman <ddickman@nyc.rr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] to init/main.c
In-Reply-To: <3B2B845F.50300@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Dickman wrote:
> Here is a small patch to main.c.
> 
> It does the following:
> - makes sure that asm/mtrr.h actually gets included, and

> --- linux-2.4.5/init/main.c     Tue May 22 12:35:42 2001
> +++ linux/init/main.c   Sat Jun 16 11:48:42 2001
> @@ -50,7 +50,7 @@
>  #endif
> 
>  #ifdef CONFIG_MTRR
> -#  include <asm/mtrr.h>
> +#include <asm/mtrr.h>
>  #endif

huh?

There is absolutely nothing wrong with that include line.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
