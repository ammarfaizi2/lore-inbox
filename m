Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285484AbRLGTwF>; Fri, 7 Dec 2001 14:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285489AbRLGTv4>; Fri, 7 Dec 2001 14:51:56 -0500
Received: from freesurfmta05.sunrise.ch ([194.230.0.18]:38585 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id <S285484AbRLGTvi>; Fri, 7 Dec 2001 14:51:38 -0500
Message-ID: <3C111DCB.6040608@bluewin.ch>
Date: Fri, 07 Dec 2001 20:51:39 +0100
From: Nicolas Vollmar <nv@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1pre6 compile error setup.c
In-Reply-To: <3C0B853000063099@freesurfmail.sunrise.ch> (added by	    postmaster@freesurf.ch)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the blk.h of kernel 2.4.16 are the declarations:

extern int rd_image_start;
extern int rd_doload;
extern int rd_promt;

In the blk.h of 2.5.1-pre6 aren't they;


>I had tried to compile 2.5.1-pre6 and have got this error:
>
>
>setup.c: In function `setup_arch':
>setup.c:806: `rd_image_start' undeclared (first use in this function)
>setup.c:806: (Each undeclared identifier is reported only once
>setup.c:806: for each function it appears in.)
>setup.c:807: `rd_prompt' undeclared (first use in this function)
>setup.c:808: `rd_doload' undeclared (first use in this function)
>make[1]: *** [setup.o] Error 1
>make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
>make: *** [_dir_arch/i386/kernel] Error 2
>
>
>Nicolas
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



