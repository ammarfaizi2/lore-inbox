Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVJUUGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVJUUGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVJUUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:06:00 -0400
Received: from magic.adaptec.com ([216.52.22.17]:30366 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965158AbVJUUF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:05:59 -0400
Message-ID: <43594A1C.3090903@adaptec.com>
Date: Fri, 21 Oct 2005 16:05:48 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <20051021194105.GB3364@parisc-linux.org> <435945F4.3000005@adaptec.com> <20051021195457.GC3364@parisc-linux.org>
In-Reply-To: <20051021195457.GC3364@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 20:05:52.0879 (UTC) FILETIME=[D6D86FF0:01C5D67A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 15:54, Matthew Wilcox wrote:
> 
> No.  What was advertised was a SCSI BOF which you then took over and

It was advertised as "SAS BOF" -- the person who wrote that on the message
board (reading this list currently) can verify that.

> spent the entire time talking about the Adaptec SAS driver.  You weren't
> interested in discussing wider SCSI issues.  You weren't interested in
> talking about how other vendors implemented SAS.  You weren't interested
> in discussing how we could get the best possible SAS interface in Linux.

I still am.  What everyone now wants is SDI. And as you can see I've posted
several times _code_ and templates as to how to do a backend which would
work as per spec and a front end which would be adjustable to the whims of
"the community", sg/sysfs/whatever1/whatever2.

I think SDI will completely satisfy everyone's needs, independently of
the fact whether the the protocol is hidden in the FW or not.

In fact Fusion MPT is very cool: you only add a few PCI IDs and your
hw works with the same driver!  And if you care about protocol
specifics: use SDI.

But the community wanted involvement so then you say: "No! Give us
your hardware, we'll do it for you." and then you get into this
never-ending goose chase, implementing the wrong thing, the wrong way,
as opposed to _listening_ to what is actually wanted.

> You shut down other people when they tried to discuss these things.
> It was a complete waste of time.

Sorry you feel this way.  I don't remember you saying anything about
SAS.
	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
