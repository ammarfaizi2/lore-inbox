Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVBFMsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVBFMsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBFMsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:48:55 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:62091 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261215AbVBFMsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:48:40 -0500
Date: Sun, 6 Feb 2005 13:48:32 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206124832.GE30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206123355.GB30109@wotan.suse.de> <1107693622.22680.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107693622.22680.86.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 01:40:22PM +0100, Arjan van de Ven wrote:
> On Sun, 2005-02-06 at 13:33 +0100, Andi Kleen wrote:
> > > Your main objection is that *incorrect* programs that assume they can
> > > execute malloc() code without PROT_EXEC protection. For legacy binaries
> > > keeping this behavior makes sense, no objection from me.
> > > 
> > > For newly compiled programs this is just wrong and incorrect.
> > 
> > That's not true as the grub/mono/... experience shows. 
> 
> both those apps are buggy and incorrect though and should be fixed.

They worked fine forever - and suddenly you define them as buggy.
This might be, but it's still quite bad to change the definition
of what is buggy and what is not so suddenly in a "mostly stable"
release series. And who tells the users what is considered buggy
this week?

-Andi
