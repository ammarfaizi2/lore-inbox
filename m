Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVI1WZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVI1WZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVI1WZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:25:06 -0400
Received: from mail0.lsil.com ([147.145.40.20]:25065 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751125AbVI1WZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:25:04 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C043889D9@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: ltuikov@yahoo.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into 
	the kernel
Date: Wed, 28 Sep 2005 16:17:22 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 28, 2005 10:59 AM, Luben Tuikov wrote:
> On 09/28/05 11:15, Moore, Eric Dean wrote:
> > Luben: I guess you didn't get what I meant.
> > 
> > I was referring that there are other
> > *vendors* (not LSI, e.g MegaRAID) that are 
> > working on sas solutions with sas firmware 
> > implementation. One that comes to mind is
> > Intel SunRise Lake, which is non a MPT based 
> > solution, that would work with Christophs 
> > Sas Layer. There maybe others, such as emulex.
> > Perhaps James S. could comment on that.
> 
> This means that they have an IOP on the same
> silicone or on the same packaging.
> 
> This means, again that they'd done all transport
> specific tasks in the FW (by the IOP).
> 

Can you stop this tirade, e.g. conspiracy theory,
in regards to LSI/MPT and the transport layer?
That is not the case.   There will be other sas 
solutions that implement discovery, and 
sas/sata translation in firmware, higher level
event handling.
  

> Again, such solutions do _not_ need the
> SAS Transport Layer.
> 
> They don't even need the attributes, but
> as a "nice to have" feature, you can use
> transport attributes.

Have you forgotten about CSMI/SDI?  It was
nearly a year ago I got blasted when I posted
a sas driver with all those IOCTLs.  CSMI/SDI
is more than a "nice to have" feature.
Its taken quite a bit of time(and greif)
to re-design the driver so it will work with
the transport layers in the way people on this
forum wanted it. Trust me, its been painful.

> 
> You, as technical person, should recognize
> the different needs and thus the different
> solutions between LSI's implementation and
> Adaptec's.
> 
> I'm surprised you never chimed in in defense
> of the _different_ technology.
> 
> See, I've mentioned many times that the two
> radically different technologies can coexist.
> But I've not heard any technical word
> from the other guys: you.
> 

I just don't have time to engage you.
I've got work to do, customer requests, issues,
etc.

Eric Moore
