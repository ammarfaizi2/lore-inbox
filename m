Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWH1JXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWH1JXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWH1JXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:23:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:16089 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751326AbWH1JXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:23:54 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: linux on Intel D915GOM oops
Date: Mon, 28 Aug 2006 11:23:49 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, henti@geekware.co.za
References: <20060828102149.26b05e8b@yoda.foad.za.net> <p7364gddzdm.fsf@verdi.suse.de> <1156754850.3034.169.camel@laptopd505.fenrus.org>
In-Reply-To: <1156754850.3034.169.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281123.49027.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 10:47, Arjan van de Ven wrote:
> On Mon, 2006-08-28 at 10:43 +0200, Andi Kleen wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > > 
> > > this is the known bug where by default Linux uses the BIOS services for
> > > PCI rather than the native method.
> > 
> > It's a BIOS bug if the PCI BIOS doesn't work, not a Linux bug.
> 
> it's a bios bug if it doesn't work.
> it's a linux mistake to depend on the bios for this in the first place
> (since other OSes don't use this afaik)


The patch that fixed the order changed it just from random to 
consistent.

But as discussed earlier if someone can show that 2.4 did it the other
way around consistently we can change the order to be like 2.4.

-Andi
