Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSGKDuu>; Wed, 10 Jul 2002 23:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317753AbSGKDut>; Wed, 10 Jul 2002 23:50:49 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:61691 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317752AbSGKDus>; Wed, 10 Jul 2002 23:50:48 -0400
Date: Wed, 10 Jul 2002 21:53:25 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.25 net/core/Makefile
Message-ID: <Pine.LNX.4.44.0207102147400.5067-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Jul 9, 2002 02:13:30, Keith Owens wrote:
> +# See p8022 in net/802/Makefile for config options to check
> +ifneq ($(subst n,,$(CONFIG_LLC)$(CONFIG_TR)$(CONFIG_IPX)$(CONFIG_ATALK)),)
>  obj-y += ext8022.o
>  endif

Make's response:

make[4]: Entering directory `/home/thunder/tmp/thunder-2.5-kb24/net/core'
Makefile:20: *** missing separator.  Stop.
make[4]: Leaving directory `/home/thunder/tmp/thunder-2.5-kb24/net/core'
make[3]: *** [core] Error 2

Ideas?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

