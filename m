Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSJPQna>; Wed, 16 Oct 2002 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265202AbSJPQna>; Wed, 16 Oct 2002 12:43:30 -0400
Received: from [203.117.131.12] ([203.117.131.12]:51412 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S265201AbSJPQn3>; Wed, 16 Oct 2002 12:43:29 -0400
Message-ID: <3DAD988B.40704@metaparadigm.com>
Date: Thu, 17 Oct 2002 00:49:15 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Simon Roscic <simon.roscic@chello.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at> <200210152153.08603.simon.roscic@chello.at> <3DACD41F.2050405@metaparadigm.com> <200210161828.18985.simon.roscic@chello.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/02 00:28, Simon Roscic wrote:

>>This was happening in pretty much all kernels I tried (a variety of
>>redhat kernels and aa kernels). Removing LVM has solved the problem.
>>Although i was blaming LVM - maybe it was a buffer overflow in qla driver.
> 
> looks like i had a lot of luck, because my 3 servers wich are using the
> qla2x00 5.36.3 driver were running without problems, but i'll update to 6.01
> in the next few day's.
> 
> i don't use lvm, the filesystem i use is xfs, so it smells like i had a lot of luck for 
> not running into this problem, ...

Seems to be the correlation so far. qlogic driver without lvm works okay.
qlogic driver with lvm, oopsorama.

~mc

