Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWGULUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWGULUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 07:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWGULUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 07:20:04 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35516 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161048AbWGULUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 07:20:03 -0400
Date: Fri, 21 Jul 2006 14:20:02 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Panagiotis Issaris <takis@gna.org>, Jeff Garzik <jgarzik@pobox.com>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset tok(z|c)alloc.
In-Reply-To: <44C0B439.8020604@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.58.0607211409540.27644@sbz-30.cs.Helsinki.FI>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <1153474342.9489.8.camel@hemera>
 <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI>
 <44C0B439.8020604@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in time, I wrote:
> > There are things that are almost generally agreed upon, such as 
> > removal of redundant typecasts, redundant wrappers, and moving 
> > assignment out of if statement expression. Formatting and the dreaded
> > sizeof thing, however, are not, so it is best to keep them as-is.

On Fri, 21 Jul 2006, Stefan Richter wrote:
> Contributors can't know what the (supposed) _agreements_ are.
> 
> Contributors can only know what the _documented conventions_ are.

Life gets easier when you accept the fact that there are different 
conventions within the kernel, driven by maintainer preference. Which is 
why it is impossible to document a definite set of conventions too. 
CodingStyle really is just a good approximation what kernel code should 
look like. If you deviate from it too much, everyone agrees that 
you're violating it, but there definitely is room for maintainer 
preference. As a contributor, when you accept that, you'll have much 
greater chances of getting your patches merged.

				Pekka
