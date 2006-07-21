Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWGULNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWGULNB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 07:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWGULNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 07:13:01 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:23194 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1161038AbWGULNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 07:13:00 -0400
Message-ID: <44C0B5FA.9090802@s5r6.in-berlin.de>
Date: Fri, 21 Jul 2006 13:09:46 +0200
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>	 <200607210850.17878.eike-kernel@sf-tec.de>	 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>	 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com> <44C0B23F.5090808@s5r6.in-berlin.de>
In-Reply-To: <44C0B23F.5090808@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Jesper Juhl wrote:
>> Who says it's "better style" ?
> 
> I correct myself: s/better/conforming/

PS: By which I don't want to deny that this style may have objective
benefits.
-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
