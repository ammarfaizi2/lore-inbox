Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268222AbTBNHEn>; Fri, 14 Feb 2003 02:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268223AbTBNHEn>; Fri, 14 Feb 2003 02:04:43 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:53774 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S268222AbTBNHEm>;
	Fri, 14 Feb 2003 02:04:42 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A336@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "''Christoph Hellwig ' '" <hch@infradead.org>
Cc: "''jsimmons@infradead.org ' '" <jsimmons@infradead.org>,
       "''Linux Kernel Mailing List ' '" 
	<linux-kernel@vger.kernel.org>,
       "''Alan Cox ' '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) consol
	 e
Date: Fri, 14 Feb 2003 16:14:32 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: 'Christoph Hellwig '
To: Osamu Tomita
Cc: 'jsimmons@infradead.org '; 'Linux Kernel Mailing List '; 'Alan Cox '
Sent: 2003/02/14 14:52
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) console

> On Fri, Feb 14, 2003 at 11:50:09AM +0900, Osamu Tomita wrote:
>> > Please set CONFIG_KANJI in the Kconfig file and in general
>> > the CONFIG_KANJI usere look really messy.  I don't think it's
>> > easy to get them cleaned up before 2.6, you might get in contact
>> > with James who works on the console layer to properly integrate
them.
>> I think too, CONFIG_KANJI needs cleanup.
> 
> I think the major point here is:  PC98 support does have a fair chance
> to get into 2.6 (with a little bit more work).  Kanji console support
> certainly won't go in.  Maybe you'll remove Kanji support for the
> patchkit submitted for inclusion - this will make reviewing the rest
> easier.
PC98 patch without CONFIG_KANJI works. I had tested already.
If 2.6 supports PC98 by removing kanji support, I think it's better.

Thanks,
Osamu Tomita

