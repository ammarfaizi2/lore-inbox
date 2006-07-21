Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWGUKn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWGUKn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWGUKn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:43:29 -0400
Received: from outmx025.isp.belgacom.be ([195.238.4.49]:5548 "EHLO
	outmx025.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161030AbWGUKn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:43:29 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset tok(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Jeff Garzik <jgarzik@pobox.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
In-Reply-To: <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI>
References: <20060720190529.GC7643@lumumba.uhasselt.be>
	 <200607210850.17878.eike-kernel@sf-tec.de>
	 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>
	 <44C07CB2.1040303@pobox.com> <1153474342.9489.8.camel@hemera>
	 <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 12:42:59 +0200
Message-Id: <1153478579.9489.33.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On vr, 2006-07-21 at 13:14 +0300, Pekka J Enberg wrote:
> On Fri, 21 Jul 2006, Panagiotis Issaris wrote:
> > Ah okay. Up until now, I thought it would be okay to change the style of
> > the code if it was listed in the CodingStyle document and in any other
> > cause should be left untouched as it would be left to the maintainers
> > personal preference. That's why I explicitly asked about the "if ((buf =
> > kmalloc(...)==NULL) -> buf = kmalloc(...); if (!buf)" type of changes.
> > 
> > Ofcourse, I should have put cosmetic changes in a separate patch anyway.
> 
> At least Andrew seems to prefer cleaning up in the same patch. Anyway, I 
> don't think Jeff meant that you shouldn't do any cleanups, but that you 
> should try to respect the existing style as much possible. There are 
> things that are almost generally agreed upon, such as removal of redundant 
> typecasts, redundant wrappers, and moving assignment out of if statement 
> expression. Formatting and the dreaded sizeof thing, however, 
> are not, so it is best to keep them as-is.
Thank God! I had been preparing such a cleanup patch for several hours
last night :)

With friendly regards,
Takis

