Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWGUKij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWGUKij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWGUKij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:38:39 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64441 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161038AbWGUKii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:38:38 -0400
Date: Fri, 21 Jul 2006 13:38:37 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Panagiotis Issaris <takis@gna.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Jeff Garzik <jgarzik@pobox.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to	k(z|c)alloc.
In-Reply-To: <1153478157.9489.30.camel@hemera>
Message-ID: <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
References: <20060720190529.GC7643@lumumba.uhasselt.be> 
 <200607210850.17878.eike-kernel@sf-tec.de> 
 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> 
 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> 
 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
 <1153478157.9489.30.camel@hemera>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On vr, 2006-07-21 at 12:20 +0200, Jesper Juhl wrote:
> > Who says it's "better style" ?

On Fri, 21 Jul 2006, Panagiotis Issaris wrote:
> Documentation/CodingStyle does :) (which in fact, I only noticed when I
> was validating someone's remark that it would be a good idea to change
> sizeof's)

Yeah, that's what Andrew prefers but there are maintainers that disagree 
with that.

				Pekka
