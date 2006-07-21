Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWGULFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWGULFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 07:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWGULFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 07:05:31 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:15770 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751094AbWGULFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 07:05:30 -0400
Message-ID: <44C0B439.8020604@s5r6.in-berlin.de>
Date: Fri, 21 Jul 2006 13:02:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Panagiotis Issaris <takis@gna.org>, Jeff Garzik <jgarzik@pobox.com>,
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>  <200607210850.17878.eike-kernel@sf-tec.de>  <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>  <44C07CB2.1040303@pobox.com> <1153474342.9489.8.camel@hemera> <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> At least Andrew seems to prefer cleaning up in the same patch. Anyway, I 
> don't think Jeff meant that you shouldn't do any cleanups, but that you 
> should try to respect the existing style as much possible.

First and foremost, respect that the Linux sources need to have a
minimum level of stylistic uniformity.

> There are 
> things that are almost generally agreed upon, such as removal of redundant 
> typecasts, redundant wrappers, and moving assignment out of if statement 
> expression. Formatting and the dreaded sizeof thing, however, 
> are not, so it is best to keep them as-is.

Contributors can't know what the (supposed) _agreements_ are.

Contributors can only know what the _documented conventions_ are.
-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
