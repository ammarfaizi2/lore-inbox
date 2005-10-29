Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVJ2RaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVJ2RaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJ2RaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:30:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:32460 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751168AbVJ2RaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:30:24 -0400
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200510291841.49214.ak@suse.de>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
	 <Pine.OSF.4.61.0510291312160.426625@rock.it.helsinki.fi>
	 <Pine.OSF.4.61.0510291749360.404250@rock.it.helsinki.fi>
	 <200510291841.49214.ak@suse.de>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 19:30:17 +0200
Message-Id: <1130607017.12551.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 18:41 +0200, Andi Kleen wrote:
> On Saturday 29 October 2005 16:54, Janne M O Heikkinen wrote:
> > On Sat, 29 Oct 2005, Janne M O Heikkinen wrote:
> > 
> > > No, I get same panics with numa=noacpi or even with numa=off. If I compile
> > > 2.6.14 kernel without CONFIG_ACPI_NUMA it does boot.
> > 
> > It wasn't removing of CONFIG_ACPI_NUMA that made it boot after all, I had
> > also changed memory model from "Sparse" to "Discontiguous". And now
> > when I recompiled with CONFIG_ACPI_NUMA=y and with "Discontiguous" memory
> > model it booted just fine.
> 
> Ok, that would explain it. I never test sparse, only discontiguous.
> sparse is only an experimental option that is not really maintained
> yet. 	Probably need to disable it if it's broken.
> 
> Perhaps Dave H. knows what to do with it.

I'll try to dig up an Opteron machine on Monday and see what I can do.

-- Dave

