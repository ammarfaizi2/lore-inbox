Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136006AbRD0NFE>; Fri, 27 Apr 2001 09:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135993AbRD0NEz>; Fri, 27 Apr 2001 09:04:55 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:11402 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S135971AbRD0NEn>;
	Fri, 27 Apr 2001 09:04:43 -0400
Date: Fri, 27 Apr 2001 09:01:07 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: Yiping Chen <YipingChen@via.com.tw>
cc: "'kernel@kvack.org'" <kernel@kvack.org>,
        "'Vivek Dasmohapatra'" <vivek@etla.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D57A@EXCHANGE2>
Message-ID: <Pine.LNX.4.33.0104270857560.12578-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when you install redhat linux, you can select to install the
kernel-include and kernel-source
but I think the kernel include files come with redhat7 (i am not sure
about rh6) won't let you to compile a kernel module by using
/usr/include/linux (they ask you to use /usr/src/linux-xxx)

you can dnload the kernel source from ftp://ftp.kernel.org and build you
own kernel/NIC driver.

Alex

On Fri, 27 Apr 2001, Yiping Chen wrote:

> I have a important question about compile driver here, sometimes we install
> RedHat Linux
> When you boot the system , it will not include the kernel source, if we
> don't have kernel source ,
> whether can we compile the driver (NIC).
> I am confused, beacuse we need include many kernel header file, if you don't
> have linux kernel
> source (I means that there is no kernel source in /usr/src, whether we can
> compile the driver module
> successfully?), whether we can just use the header file in /usr/include?
> thanks!!
> Yiping Chen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
| Feng Xian *
|    (o_    *
|    //\    *
|    V_/_   *

