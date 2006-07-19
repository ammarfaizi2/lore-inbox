Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWGSBjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWGSBjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGSBjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:39:11 -0400
Received: from outmx025.isp.belgacom.be ([195.238.4.49]:36506 "EHLO
	outmx025.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932454AbWGSBjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:39:11 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to
	k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <20060719005905.GC6815@martell.zuzino.mipt.ru>
References: <20060719004659.GA30823@lumumba.uhasselt.be>
	 <20060719005905.GC6815@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 03:38:35 +0200
Message-Id: <1153273116.11873.4.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On wo, 2006-07-19 at 04:59 +0400, Alexey Dobriyan wrote:
> On Wed, Jul 19, 2006 at 02:46:59AM +0200, Panagiotis Issaris wrote:
> > drivers: Conversions from kmalloc+memset to k(z|c)alloc.
> 
> This patch doesn't remove trivial wrappers around kzalloc.
I'll change this in an updated patch. I wasn't really sure this was 
needed/wanted as I could imagine these driver_alloc() functions enabling
easier debugging of driver specific allocation code (Meaning that you 
can add whatever debugging code to just this specific driver's memory
allocation code).

With friendly regards,
Takis



