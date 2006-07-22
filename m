Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWGVUD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWGVUD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWGVUD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 16:03:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63365 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751031AbWGVUD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 16:03:59 -0400
Message-ID: <44C28472.2080509@pobox.com>
Date: Sat, 22 Jul 2006 16:02:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Stefan Richter <stefanr@s5r6.in-berlin.de>,
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>  <200607210850.17878.eike-kernel@sf-tec.de>  <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>  <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>  <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com> <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI> <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl> <44C26D90.4030307@s5r6.in-berlin.de> <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:
> Moment .. are you want to say something like "keep commont coding style 
> can't be maintained by tool" ?
> Even if indent watches on to small coding style emenets still I don't 
> see why using this tool isn't one of the current ement of release 
> procedure (?).

indent isn't perfect, _especially_ where C99 comes into the picture.

And running indent across the tree pre-release would (a) create a ton of 
noise before each release, and (b) undo perfectly valid, readable 
formatting.

scripts/Lindent exists and gets used, but it is not perfect.

	Jeff


