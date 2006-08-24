Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422763AbWHXWVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWHXWVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWHXWVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:21:39 -0400
Received: from web83114.mail.mud.yahoo.com ([216.252.101.43]:18524 "HELO
	web83114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422763AbWHXWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:21:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=au7OS/VvvQlUukbmsHKRYCgY6j3vrxQjhQ9hQ0xhS13pO4B93xq1Ap3ktfIDpw2zMkyMFJv/KANuMBjM3XeqMQPazt+xS8cuF90TYLBpKGBsxaZZisulTC9un+zw2I7bduLwpRdNugThuqQ3cQh9uZQqmCT/HWaB1KbEInMgPkU=  ;
Message-ID: <20060824222136.49055.qmail@web83114.mail.mud.yahoo.com>
Date: Thu, 24 Aug 2006 15:21:36 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: RE: Generic Disk Driver in Linux
To: Arjan van de Ven <arjan@infradead.org>
Cc: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <1156449809.3014.84.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Arjan van de Ven <arjan@infradead.org> wrote:


> > > 
> > > it'll be easier and quicker to rev engineer 5 more formats than it will
> > > be to get the bios thing working ;) And the performance of the bios
> > probably true - I'm actually not great fan of originally proposed approach. But, 
> > unfortunately, manufactures and vendors still look more to MS. Until market 
> > situation changes, there is always a gap...
> 
> there are only so many different ways to describe raid0.
> And those companies aren't going to keep changing that "just because",
> changing costs them money, so there is an incentive for them to keep it
> as is

Bottom line is - today there is lack of support for it, and for some companies it 
means loosing money. Tomorrow there will be support for all raid0 variants, but 
as well some kind of new unsupported hw/technology - hence gap is still there, 
spiral thing :-( Nothing we can do here but to improve support in Linux today in
a hope it will take bigger market share tomorrow.

> 
> > 
> > > thing will be really really bad... (hint: real mode can access only 1Mb
> > > of memory, so you will bounce buffer all IO's)
> > This is true for non-dma case only. As I already mentioned before, most BIOSes 
> > support dma, and there is no 1Mb limit for that (at least on modern hw).
> 
> but only DMA to lower regions usually

  It depends on your memory manager. Virtual DMA services (aka VDS) are there and being
used from 1992 (for instance, in emm386 - Linux's memory management is more powerfull than that).

