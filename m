Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262909AbSJWHx1>; Wed, 23 Oct 2002 03:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJWHx1>; Wed, 23 Oct 2002 03:53:27 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56252 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262909AbSJWHxZ>; Wed, 23 Oct 2002 03:53:25 -0400
Subject: Re: [PATCH] niceness magic numbers, 2.4.20-pre11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kristis Makris <devcore@freeuk.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0210222332480.15859-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0210222332480.15859-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 09:16:01 +0100
Message-Id: <1035360961.4033.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 07:37, Randy.Dunlap wrote:
> --- ./include/linux/resource.h.nice	Tue Jun 18 20:10:36 2002
> +++ ./include/linux/resource.h	Sat Oct 19 13:55:10 2002
> @@ -43,7 +43,7 @@
>  };
> 
>  #define	PRIO_MIN	(-20)
> -#define	PRIO_MAX	20
> +#define	PRIO_MAX	19

I suspect this isnt correct

