Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWGFSI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWGFSI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWGFSI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:08:29 -0400
Received: from colin.muc.de ([193.149.48.1]:59141 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750823AbWGFSI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:08:28 -0400
Date: 6 Jul 2006 20:08:26 +0200
Date: Thu, 6 Jul 2006 20:08:26 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060706180826.GA95795@muc.de>
References: <20060704092358.GA13805@muc.de> <1152007787.28597.20.camel@localhost.localdomain> <20060704113441.GA26023@muc.de> <1152137302.6533.28.camel@localhost.localdomain> <20060705220425.GB83806@muc.de> <m1odw32rep.fsf@ebiederm.dsl.xmission.com> <20060706130153.GA66955@muc.de> <m18xn621i6.fsf@ebiederm.dsl.xmission.com> <20060706165159.GB66955@muc.de> <m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 11:46:00AM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@muc.de> writes:
> 
> >> With EDAC on my next boot I get positive confirmation that I either
> >> pulled the DIMM that the error happened on, or I pulled a different
> >> DIMM.
> >
> > How? You simulate a new error and let EDAC resolve it?
> 
> No. There is a status report that tells you which pieces of hardware
> your memory controller sees.  It is just a simple list.

Ok but that could be also done easily in user space that reads
PCI config space. No need for a complicated kernel driver at all.

> Isn't something that just works, and is not at the mercy of the BIOS
> developers with too little time worth doing?

I just don't see how it's very useful if you don't know which DIMM
to replace in the first place. And to know that in your scheme you need
your magical database with all motherboards ever shipped, which
I don't consider realistic.

-Andi

