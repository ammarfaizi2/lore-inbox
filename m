Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265151AbSJPQWb>; Wed, 16 Oct 2002 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSJPQWb>; Wed, 16 Oct 2002 12:22:31 -0400
Received: from viefep14-int.chello.at ([213.46.255.13]:9255 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id <S265151AbSJPQW3>; Wed, 16 Oct 2002 12:22:29 -0400
From: Simon Roscic <simon.roscic@chello.at>
To: Michael Clark <michael@metaparadigm.com>
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Date: Wed, 16 Oct 2002 18:28:18 +0200
User-Agent: KMail/1.4.7
References: <200210152120.13666.simon.roscic@chello.at> <200210152153.08603.simon.roscic@chello.at> <3DACD41F.2050405@metaparadigm.com>
In-Reply-To: <3DACD41F.2050405@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210161828.18985.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 04:51, Michael Clark <michael@metaparadigm.com>  wrote:
> Version 6.1b5 does appear to be a big improvement from looking
> at the code (certainly much more readable than version 4.x end earlier).
i'll try version 6.01 or so next week and i will see what happens.
thanks for your help.

> Although the method for creating the different modules for
> different hardware is pretty ugly.
>...
i see.

> This was happening in pretty much all kernels I tried (a variety of
> redhat kernels and aa kernels). Removing LVM has solved the problem.
> Although i was blaming LVM - maybe it was a buffer overflow in qla driver.
looks like i had a lot of luck, because my 3 servers wich are using the
qla2x00 5.36.3 driver were running without problems, but i'll update to 6.01
in the next few day's.

i don't use lvm, the filesystem i use is xfs, so it smells like i had a lot of luck for 
not running into this problem, ...


simon.
(please CC me, i'm not subscribed to lkml)
