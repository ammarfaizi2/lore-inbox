Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317927AbSGVXMX>; Mon, 22 Jul 2002 19:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSGVXMX>; Mon, 22 Jul 2002 19:12:23 -0400
Received: from [213.4.129.129] ([213.4.129.129]:58532 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id <S317927AbSGVXMX>;
	Mon, 22 Jul 2002 19:12:23 -0400
Date: Tue, 23 Jul 2002 01:15:12 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Erlend Aasland <erlend-a@innova.no>
Cc: linux-kernel@vger.kernel.org, fdavis@si.rr.com
Subject: Re: Compile error 2.5.27: [ad1848_lib.o] Error 1
Message-Id: <20020723011512.082a87c7.diegocg@teleline.es>
In-Reply-To: <20020723010030.A14440@innova.no>
References: <20020722233021.4713583a.diegocg@teleline.es>
	<20020723010030.A14440@innova.no>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 01:00:30 +0200
Erlend Aasland <erlend-a@innova.no> escribió:

> Hi,
> 
> Does this patch make it compile?

Yes it does ;)


> 
> --- clean/sound/isa/ad1848/ad1848_lib.c	2002-07-06 01:42:22.000000000 +0200
> +++ dirty/sound/isa/ad1848/ad1848_lib.c	2002-07-10 04:50:20.000000000 +0200
> @@ -24,6 +24,7 @@
>  #include <asm/io.h>
>  #include <asm/dma.h>
>  #include <linux/delay.h>
> +#include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/ioport.h>
>  #include <sound/core.h>
> 
> 
> Regards,
> 	Erlend Aasland
