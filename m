Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTCEFvW>; Wed, 5 Mar 2003 00:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTCEFvW>; Wed, 5 Mar 2003 00:51:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3779 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262469AbTCEFvV>;
	Wed, 5 Mar 2003 00:51:21 -0500
Message-ID: <32981.4.64.238.61.1046844111.squirrel@www.osdl.org>
Date: Tue, 4 Mar 2003 22:01:51 -0800 (PST)
Subject: Re: Reserving physical memory at boot time
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <hpa@zytor.com>
In-Reply-To: <b442s0$pau$1@cesium.transmeta.com>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com>
        <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>
        <b442s0$pau$1@cesium.transmeta.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Followup to:
> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net> By author:
>  "Randy.Dunlap" <rddunlap@osdl.org>
> In newsgroup: linux.dev.kernel
>>
>> Patch for 'mem=exactmap' in 2.4 was submitted several weeks ago and Alan
>> merged it into -ac.  It does need to be pushed to Marcelo...
>>
>
> Once again, with feeling...
>
> DON'T CALL IT mem=.
>
> mem= is part of the boot protocol.
> Call it memmap= or something, or you'll break boot loaders in weird and
> subtle ways.

OK, with feeling:

I agree with you since the boot protocol is well-defined.

Just to be clear, my comment was referring to
Documentation/kernel-parameters.txt, not to any C code.

And it would really be helpful to catch issues like this soon
after they happen...

Thanks,
~Randy



