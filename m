Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWGUK5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWGUK5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWGUK5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:57:07 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:154 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750942AbWGUK5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:57:06 -0400
Message-ID: <44C0B23F.5090808@s5r6.in-berlin.de>
Date: Fri, 21 Jul 2006 12:53:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060720190529.GC7643@lumumba.uhasselt.be>	 <200607210850.17878.eike-kernel@sf-tec.de>	 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>	 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
In-Reply-To: <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 21/07/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>>  - better style of the size argument where correct,
> 
> Who says it's "better style" ?

I correct myself: s/better/conforming/
-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
