Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbRGBOhd>; Mon, 2 Jul 2001 10:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbRGBOhW>; Mon, 2 Jul 2001 10:37:22 -0400
Received: from t2.redhat.com ([199.183.24.243]:14578 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263608AbRGBOhR>; Mon, 2 Jul 2001 10:37:17 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <31885.993874778@ocs3.ocs-net> 
In-Reply-To: <31885.993874778@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Byeong-ryeol Kim <jinbo21@hananet.net>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: compile error about do_softirq in 2.4.5-ac21 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 15:36:47 +0100
Message-ID: <4888.994084607@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
> --- 5.52/fs/jffs2/background.c Sun, 22 Apr 2001 07:25:55 +1000 kaos (linux-2.4/Z/d/7_background 1.1 644)
> +++ 5.52(w)/fs/jffs2/background.c Sat, 30 Jun 2001 14:13:12 +1000 kaos (linux-2.4/Z/d/7_background 1.1 644)
> @@ -43,6 +43,7 @@
>  #include <linux/jffs2.h>
>  #include <linux/mtd/mtd.h>
> +#include <linux/interrupt.h>
>  #include <linux/smp_lock.h>
>  #include "nodelist.h"

Thanks. I've applied that to my tree - and removed smp_lock.h too. 


--
dwmw2


