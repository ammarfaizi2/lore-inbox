Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVJDPkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJDPkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVJDPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:40:31 -0400
Received: from magic.adaptec.com ([216.52.22.17]:64977 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S964812AbVJDPka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:40:30 -0400
Message-ID: <4342A261.1040808@adaptec.com>
Date: Tue, 04 Oct 2005 11:40:17 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@autoweb.net>,
       =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>  <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>  <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com>  <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl> <1128377075.23932.5.camel@ryan2.internal.autoweb.net> <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org> <434293D8.50300@adaptec.com> <43429789.8020102@pobox.com> <43429D6C.8070909@adaptec.com> <43429F1B.1000002@pobox.com>
In-Reply-To: <43429F1B.1000002@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 15:40:18.0057 (UTC) FILETIME=[EBEDCF90:01C5C8F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/05 11:26, Jeff Garzik wrote:
> You continue to misunderstand everyone else's opinion.

Internet mailing lists are one such thing where anyone
can write anything they want and sound smart.  Like
the statement above.

Did you talk to "everyone else"?  Or is this just you,
James B and Christoph?

How do you know everyone else's opinion?

Maybe because you're telling them what they should think?

> The claim is that the transport class is the method through which a 
> transport layer is plugged into the SCSI stack.  Pluggable transport 

No.  This isn't currently the case.  You're maybe making it now
to be like this, but it is currently not the case.

> classes means that SAS transport layer details go into the SAS transport 
> class (or a helper lib).  SPI (parallel/legacy SCSI) transport layer 
> details should move to the SPI transport class.

"should", "will".

The question is then: Where were you Jeff all this time?

Why did the SAS code had to be posted for SCSI Core to see how many
things it needs to repair.

I've been pointing those things out since, oh well, for many years
now.

> You misunderstood that everybody, but you, has moved on to the "what do 
> we do about this" phase.

If SCSI Core had seen the necessary over the years changes,
it wouldn't be in this situation now.

> Nothing is upside down.  Transport details plug into an obvious location 
> -- the transport class, and associated helper libs (if any).

USB/SAS/SBP:
HW -> LLDD -> Transport Layer -> SCSI Core

MPT:
HW -> Transport Layer (FW) -> LLDD -> SCSI Core.

	Luben


