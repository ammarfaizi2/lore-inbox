Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbTBNGcc>; Fri, 14 Feb 2003 01:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268221AbTBNGcb>; Fri, 14 Feb 2003 01:32:31 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:22030 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S268217AbTBNGcb>;
	Fri, 14 Feb 2003 01:32:31 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A334@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "''Christoph Hellwig ' '" <hch@infradead.org>,
       Osamu Tomita <tomita@cinet.co.jp>
Cc: "''Linux Kernel Mailing List ' '" <linux-kernel@vger.kernel.org>,
       "''Alan Cox ' '" <alan@lxorguk.ukuu.org.uk>,
       "''Jeff Garzik ' '" <jgarzik@pobox.com>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.60 (13/34) NIC
Date: Fri, 14 Feb 2003 15:42:22 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: 'Christoph Hellwig '
To: Osamu Tomita
Cc: 'Linux Kernel Mailing List '; 'Alan Cox '; 'Jeff Garzik '
Sent: 2003/02/14 14:43
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (13/34) NIC

> On Fri, Feb 14, 2003 at 01:21:36PM +0900, Osamu Tomita wrote:
>> #if deined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
>> Each places are better?
> 
> Yes.
Thanks.

>> PC98 has no EL3 PNP card, but has other PNP cards.
> 
> Does isapnp probing for EL3 cards actually causes any problems on
> PC98?  If not I'd say just leave the code in.
Yes. I can't test on 2.5.60. But older kernel caused problem.

--
Osamu Tomita

