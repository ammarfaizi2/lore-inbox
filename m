Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUFWSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUFWSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUFWSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:07:57 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:49626 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S265840AbUFWSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:07:56 -0400
Date: Wed, 23 Jun 2004 21:04:32 +0300
From: Anssi Saari <as@sci.fi>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: booting 2.6.7 hangs with IRQ handling problems
Message-ID: <20040623180431.GA8963@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20040622192942.GA15367@sci.fi> <200406231748.33679.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406231748.33679.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 05:48:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 22 of June 2004 21:29, Anssi Saari wrote:
> > 
> > Hello,
> 
> Hi,
> 
> > On my home PC I have an AMD Athlon XP 1900+ on an Aopen AK77-600Max
> > motherboard, VIA KT600 chipset. It works fine with Linux 2.6.6, apart
> > from the apparently nonexistent support for PATA devices on the Promise
> > PDC20378, but I can't boot 2.6.7. I've tried vanilla 2.6.7, 2.6.7 with
> > acpi-20040326 patch and 2.6.7-bk4. acpi=off, noapic or nolapic don't
> > seem to help.
> 
> Since 2.6.6 works and 2.6.7-bk4 doesn't can you try -bk1/2/3 and
> do bisection search on specific changesets?  Thanks!

OK. I find that 2.6.6-bk1 seemed fine, but 2.6.6-bk2 already prints out
these messages. It did boot, but then hanged shortly after. I hope this
helps to narrow it down?

Anssi


