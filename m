Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWHXTkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWHXTkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWHXTkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:40:15 -0400
Received: from web83101.mail.mud.yahoo.com ([216.252.101.30]:7319 "HELO
	web83101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030417AbWHXTkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WMGhDbjhtyh7J2iapwcThHpJZWRqatzGD4tpqhiiGrOv//k8OCMfabQE7zZxgbTISZ98I5bPrAvzERCFoQX9zCoTwnHc6KN16q6riWcxy8VUdlmgS9A/Zgd1Sv4FX1i/vDdbiLZR+lg9v8yCP5uDumB1ytjgMFeZCj4fIAtX2fs=  ;
Message-ID: <20060824194012.77909.qmail@web83101.mail.mud.yahoo.com>
Date: Thu, 24 Aug 2006 12:40:12 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: RE: Generic Disk Driver in Linux
To: arjan@infradead.org
Cc: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <1156444573.3014.82.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2006-08-24 at 11:19 -0700, Aleksey Gorelov wrote:
> > >From: linux-kernel-owner@vger.kernel.org 
> > >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> > >>
> > >> I was curious that can we develop a generic disk driver that could
> > >> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> > >
> > >ide_generic
> > >sd_mod
> > >
> > >All there, what more do you want?
> > 
> > Unfortunately, not _all_. DMRAID does not support all fake raids yet. 
> 
> Hi,
> 
> it'll be easier and quicker to rev engineer 5 more formats than it will
> be to get the bios thing working ;) And the performance of the bios
probably true - I'm actually not great fan of originally proposed approach. But, 
unfortunately, manufactures and vendors still look more to MS. Until market 
situation changes, there is always a gap...

> thing will be really really bad... (hint: real mode can access only 1Mb
> of memory, so you will bounce buffer all IO's)
This is true for non-dma case only. As I already mentioned before, most BIOSes 
support dma, and there is no 1Mb limit for that (at least on modern hw).

Aleks.

> 
> Greetings,
>    Arjan van de Ven
> 

