Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTBTEok>; Wed, 19 Feb 2003 23:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBTEok>; Wed, 19 Feb 2003 23:44:40 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:20754 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S264853AbTBTEoj>;
	Wed, 19 Feb 2003 23:44:39 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A33D@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>,
       Osamu Tomita <tomita@cinet.co.jp>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.61 (5/26) char de
	vice
Date: Thu, 20 Feb 2003 13:54:34 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the commants.

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox
Sent: 2003/02/18 19:45
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (5/26) char
device

>> +	__const_udelay(lp.wait * 4);
> 
> Why do you use __const_udelay instead of udelay?
I need nano-sec. delay for device timing.
I cleaned up lp_old98.c as your advices and sent incremental patch
to Alan. I'll post whole patch for next version.

Thanks,
Osamu Tomita


