Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVI2Q4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVI2Q4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVI2Q4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:56:13 -0400
Received: from magic.adaptec.com ([216.52.22.17]:31920 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932254AbVI2Q4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:56:12 -0400
Message-ID: <433C1CA1.3080007@adaptec.com>
Date: Thu, 29 Sep 2005 12:56:01 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com>	 <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com>	 <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com>	 <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com>	 <20050929040403.GE18716@alpha.home.local> <1127979848.2918.7.camel@laptopd505.fenrus.org> <433C0398.4040302@adaptec.com> <433C0641.3030101@pobox.com>
In-Reply-To: <433C0641.3030101@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 16:56:10.0450 (UTC) FILETIME=[B14D1B20:01C5C516]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/05 11:20, Jeff Garzik wrote:
>>Arjan, I'll be your best friend here:
>>Never say this in public or in an intervew.
> 
> 
> It's hard-earned experience.  We constantly have to teach hardware 
> vendors how to write good drivers.

I'm sure you have.  Hardware vendors are lost without
Jeff, James Bottomley and Christoph.

You see, it is because of your _enormous_ ego as shown
above, that the code is being blocked.

> At some point you have to step away from the spec, and ask yourself what 
> makes sense for Linux.

I'm sure -- flush interoperability down the drain.

> I've already had to poke T10 when they put silly 
> things in the SAT spec.

Surely they are lost without you.

> As a tangent, I already have a design for a Linux filesystem that makes 
> use of SCSI object-based storage (to James's horror, no doubt :)).  It's 
> a fun thing to ponder.

Ok, so the way I see it you want to show who has got
the bigger balls?

Jeff, I have *worked* on a Linux OBD-based filesystem.

Are you going to stop this self-gratifying stuff?

>>Hardware folks needs to work with software folks and
>>software folks need to work with hardware folks.
> 
> Certainly.  The historical disconnect is where hardware vendors tend to 
> presume They Know Best, when in reality it needs to be an equal 
> tradeoff.  Hardware vendors must admit they don't know Linux, and Linux 
> developers must admit that hardware vendors know their own hardware 
> better than anyone else.

Reflection of above:
  The historical disconnect is where "the community" tend to 
presume They Know Best, when in reality it needs to be an equal 
tradeoff.  "The community" must admit they don't know hardware,
and hardware developers must admit that "the community" know their
own code better than anyone else.

Jeff, if you had started looking at the design and firmware
of any new SCSI storage chip, you'd see how incredibly similar
it is to the transport it defines, and thus to SAM, since the
transport itself has to comply with SAM for interoperability
(TMF and all).

Linux SCSI does _not_ need to do "its own thing".  There are
perfectly well defined specs, telling you how things are
conceptually _and_ in the physical world.

In order to control those objects, you need to represent
them internally (you can learn this either in neuroscience
class or in OOD & OOP comp sci classes) as you can see has
been done in the SAS Transport Layer code.

So if you want _better control_, higher quality you need
to invent _your own_ stuff as _little as possible_ and
represent things as they are.

	Luben

