Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266840AbUFYTC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266840AbUFYTC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUFYTBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:01:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55792 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266843AbUFYTBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:01:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anssi Saari <as@sci.fi>
Subject: Re: PROBLEM: booting 2.6.7 hangs with IRQ handling problems
Date: Fri, 25 Jun 2004 21:06:03 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040622192942.GA15367@sci.fi> <200406231748.33679.bzolnier@elka.pw.edu.pl> <20040623180431.GA8963@sci.fi>
In-Reply-To: <20040623180431.GA8963@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406252106.04029.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 of June 2004 20:04, Anssi Saari wrote:
> On Wed, Jun 23, 2004 at 05:48:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 22 of June 2004 21:29, Anssi Saari wrote:
> > > Hello,
> >
> > Hi,
> >
> > > On my home PC I have an AMD Athlon XP 1900+ on an Aopen AK77-600Max
> > > motherboard, VIA KT600 chipset. It works fine with Linux 2.6.6, apart
> > > from the apparently nonexistent support for PATA devices on the Promise
> > > PDC20378, but I can't boot 2.6.7. I've tried vanilla 2.6.7, 2.6.7 with
> > > acpi-20040326 patch and 2.6.7-bk4. acpi=off, noapic or nolapic don't
> > > seem to help.
> >
> > Since 2.6.6 works and 2.6.7-bk4 doesn't can you try -bk1/2/3 and
> > do bisection search on specific changesets?  Thanks!
>
> OK. I find that 2.6.6-bk1 seemed fine, but 2.6.6-bk2 already prints out
> these messages. It did boot, but then hanged shortly after. I hope this
> helps to narrow it down?

Does it hang the same way as 2.6.7?

There were no IDE changes between 2.6.6-bk1 and 2.6.6-bk2.
Can you do a diff between dmesg outputs from -bk1 and -bk2?

You can also try narrowing it down to a specific changeset
[ http://linux.bkbits.net:8080/linux-2.5/ ] but it can take a while.

Bartlomiej

