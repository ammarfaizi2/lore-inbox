Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWGUOLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWGUOLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWGUOLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 10:11:40 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:42907 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750737AbWGUOLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 10:11:39 -0400
Message-ID: <44C0DFD9.1040609@s5r6.in-berlin.de>
Date: Fri, 21 Jul 2006 16:08:25 +0200
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>  <200607210850.17878.eike-kernel@sf-tec.de>  <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>  <44C07CB2.1040303@pobox.com> <1153474342.9489.8.camel@hemera> <Pine.LNX.4.58.0607211308590.25982@sbz-30.cs.Helsinki.FI> <44C0B439.8020604@s5r6.in-berlin.de> <Pine.LNX.4.58.0607211409540.27644@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0607211409540.27644@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Fri, 21 Jul 2006, Stefan Richter wrote:
>> Contributors can't know what the (supposed) _agreements_ are.
>> 
>> Contributors can only know what the _documented conventions_ are.
> 
> Life gets easier when you accept the fact that there are different 
> conventions within the kernel, driven by maintainer preference. Which is 
> why it is impossible to document a definite set of conventions too. 
> CodingStyle really is just a good approximation
[...]

What can a contributor do when he comes across code which deviates from
CodingStyle? He cannot tell whether the initial developer wasn't forced
to adhere to CodingStyle or the maintainer wants it that way. So, the
contributor
 - could ask the maintainer for his ruleset before writing a patch, or
 - could simply write the patch and wait if the maintainer feels need to
   demand adjustments.
I am not sure which strategy will consume less time of contributor and
maintainer.
-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
