Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSKOWbk>; Fri, 15 Nov 2002 17:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSKOWbN>; Fri, 15 Nov 2002 17:31:13 -0500
Received: from pool-151-196-237-149.balt.east.verizon.net ([151.196.237.149]:39096
	"EHLO starbug.reddwarf") by vger.kernel.org with ESMTP
	id <S266868AbSKOWaQ>; Fri, 15 Nov 2002 17:30:16 -0500
Message-ID: <3DD57713.4040305@yossman.net>
Date: Fri, 15 Nov 2002 17:37:07 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc1-ac3 compile warnings/errors (test)
References: <200211151323.gAFDNlt01818@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>  -nostdinc -iwithprefix include -DKBUILD_BASENAME=rmap  -c -o rmap.o rmap.c
>>In file included from rmap.c:31:
>>/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:17:1: warning: 
>>"kernel_locked" redefined
> 
> 
> Weird indeed. are you trying to build SMP or non SMP ?

I was trying to build non-SMP.  I have only UP boards at the moment.


Brian Davids

