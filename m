Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWHJMTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWHJMTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWHJMTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:19:40 -0400
Received: from brick.kernel.dk ([62.242.22.158]:15114 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751333AbWHJMTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:19:39 -0400
Date: Thu, 10 Aug 2006 14:20:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
Message-ID: <20060810122056.GP11829@suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain> <p733bc5nm5g.fsf@verdi.suse.de> <1155213464.22922.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155213464.22922.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2006, Alan Cox wrote:
> Ar Iau, 2006-08-10 am 08:24 +0200, ysgrifennodd Andi Kleen:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > - No support for host-protected-area yet
> > 
> > Even the support in the old one for that wasn't complete. It didn't
> > redo the HPA disabling on resume-from-ram, which made parts of the
> > disk not accessible anymore after wakeup. So at least on laptops it
> > always had to be disabled anyways.
> 
> drivers/ide does not support power management yet. Never has. Some
> people are brave and use it as it is rather than fix it.

You make it sound much worse than it is. Apart for HPA, I'm not aware of
any setups that require extra treatment. And the amount of reported bugs
against it are pretty close to zero :-)

-- 
Jens Axboe

