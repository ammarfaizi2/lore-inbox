Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275188AbRIZOC3>; Wed, 26 Sep 2001 10:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275203AbRIZOCU>; Wed, 26 Sep 2001 10:02:20 -0400
Received: from jalon.able.es ([212.97.163.2]:42439 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S275188AbRIZOCE>;
	Wed, 26 Sep 2001 10:02:04 -0400
Date: Wed, 26 Sep 2001 16:02:23 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: support for structs, unions, enum, typedef and other stuff
Message-ID: <20010926160223.A2738@werewolf.able.es>
In-Reply-To: <15m3N5-223p5sC@fmrl01.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <15m3N5-223p5sC@fmrl01.sul.t-online.com>; from tim@tjansen.de on Wed, Sep 26, 2001 at 03:22:04 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010926 Tim Jansen wrote:
>Hi...
>
>The attached patch for scripts/kernel-doc adds the following features:
>
>1. You can document structs, unions, enums and typedef like this:
>/**
> * enum driver_type - Describes the type of a driver
> * @DRIVER_TYPE_DEVICE: driver controls a device (like fd.o)
> * @DRIVER_TYPE_BUS: driver manages a bus (like usbcore.o)
> * 
> * Some description.
> */
>enum driver_type {
>	DRIVER_TYPE_DEVICE     = 0,
>	DRIVER_TYPE_BUS        = 1,
>};
>

I suppose it is too late, but can be an idea for 2.5.

Why do not use doxygen, instead of rewriting it ?

Yes, it adds another package dependency for kernel sources, but only for
people that wants to rebuild docs instead of using shipped ones.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.10-beo #1 SMP Tue Sep 25 23:38:05 CEST 2001 i686
