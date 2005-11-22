Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVKVOgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVKVOgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVKVOgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:36:12 -0500
Received: from havoc.gtf.org ([69.61.125.42]:21635 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964950AbVKVOgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:36:11 -0500
Date: Tue, 22 Nov 2005 09:36:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122143610.GD24997@havoc.gtf.org>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <1132638652.2789.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132638652.2789.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:50:52AM +0100, Arjan van de Ven wrote:
> [1] Both nvidia and ati have a way out: they can do the IP side
> (translating 3D stuff into card specific commands) in userspace and just
> pass the data to the hardware via a thin driver that just drives and
> controls the hardware. Sure it may be 5% slower, but it's a lot cleaner
> IP wise. X after all is MIT (bsd like without nasty clauses) licensed
> and allows binary components.

100% agreed...  IMO this is the best way to get open source 3D stuff.

One sticking point is validation:  ensuring userspace cannot cause
invalid GPU microcode to be generated.  [I can just hear Al Viro
swearing, just thinking about creating secure compilers...]

	Jeff



