Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbTBRApT>; Mon, 17 Feb 2003 19:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBRApT>; Mon, 17 Feb 2003 19:45:19 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:23304 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S267199AbTBRApT>;
	Mon, 17 Feb 2003 19:45:19 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A337@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Jeff Garzik '" <jgarzik@pobox.com>, Osamu Tomita <tomita@cinet.co.jp>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "''Christoph Hellwig' '" <hch@infradead.org>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC
Date: Tue, 18 Feb 2003 09:55:10 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment. 

-----Original Message-----
From: Jeff Garzik
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox; 'Christoph Hellwig'
Sent: 2003/02/18 2:02
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC

>> -#ifdef __ISAPNP__	
>> +#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
> 
> 
> I am curious, does PC9800 support ISAPNP at all?
> 
> Perhaps a dumb question, but I wonder if the above ifdef can be 
> simplified by turning off ISAPNP on PC9800?
PC98 has other PNP cards. So I think this is best way.
But most PNP cards for PC98 has hardware switch or jumper pin to
disable PNP feature. We can use them without PNP support.
Your idea is not bad.....

Thanks,
Osamu Tomita
