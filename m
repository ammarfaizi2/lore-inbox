Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWGWPWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWGWPWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 11:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWGWPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 11:22:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:42654 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751225AbWGWPWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 11:22:08 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44C392EA.1080101@s5r6.in-berlin.de>
Date: Sun, 23 Jul 2006 17:16:58 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: =?UTF-8?B?VG9tYXN6IEvFgm9jemtv?= <kloczek@rudy.mif.pg.gda.pl>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Panagiotis Issaris <takis@gna.org>, Jesper Juhl <jesper.juhl@gmail.com>,
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>  <200607210850.17878.eike-kernel@sf-tec.de>  <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>  <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>  <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com> <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI> <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl> <44C26D90.4030307@s5r6.in-berlin.de> <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl> <44C28472.2080509@pobox.com>
In-Reply-To: <44C28472.2080509@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (0.906) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tomasz Kłoczko wrote:
>> Moment .. are you want to say something like "keep commont coding 
>> style can't be maintained by tool" ?

Yes and no.

>> Even if indent watches on to small coding style emenets still I don't 
>> see why using this tool isn't one of the current ement of release 
>> procedure (?).
> 
> indent isn't perfect, _especially_ where C99 comes into the picture.
> 
> And running indent across the tree pre-release would (a) create a ton of 
> noise before each release, and (b) undo perfectly valid, readable 
> formatting.
> 
> scripts/Lindent exists and gets used, but it is not perfect.

Tomasz,

yes, we have scripts/Lindent, but it cannot and is not supposed to solve 
all style issues. Coding style is about _much_ more than whitespace. It 
includes sensible names, usage of language features...

Furthermore, much of this thread revolved around style issues where a 
common coding style is not fully established in the first place.
-- 
Stefan Richter
-=====-=-==- -=== =-===
http://arcgraph.de/sr/
