Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWGVS3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWGVS3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 14:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWGVS3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 14:29:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47774 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750953AbWGVS3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 14:29:19 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44C26D90.4030307@s5r6.in-berlin.de>
Date: Sat, 22 Jul 2006 20:25:20 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?UTF-8?B?VG9tYXN6IEvFgm9jemtv?= <kloczek@rudy.mif.pg.gda.pl>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Panagiotis Issaris <takis@gna.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060720190529.GC7643@lumumba.uhasselt.be>  <200607210850.17878.eike-kernel@sf-tec.de>  <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>  <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>  <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com> <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI> <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (0.907) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Kłoczko wrote:
> On Fri, 21 Jul 2006, Stefan Richter wrote:
>> Pekka J Enberg wrote:
>>
>>> Yeah, that's what Andrew prefers but there are maintainers that disagree
>>> with that.
>>
>> Then they should change CodingStyle.
> 
> Better will be start use indent.

Style issues like "sizeof(struct foo)" versus "sizeof(*bar)" in memory 
allocation are beyond what indent can and should do.

> Coding style seems is Linux case kind of never ending story.

It's not a big deal in my limited experience, as far as there is a 
documented consensus.

> Keep one/common coding style in this case is someting not for small tool 
> but more for .. Superman/Hecules (?)
[...]

Yes. Or subsystem maintainers who didn't already could adopt the 
documented style. Or correct the document where it doesn't reflect 
consensus.
-- 
Stefan Richter
-=====-=-==- -=== =-==-
http://arcgraph.de/sr/
