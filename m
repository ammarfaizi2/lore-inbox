Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWGVGYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWGVGYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 02:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWGVGYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 02:24:36 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:21179 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932079AbWGVGYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 02:24:36 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44C1C3BC.606@s5r6.in-berlin.de>
Date: Sat, 22 Jul 2006 08:20:44 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>,
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>	 <200607210850.17878.eike-kernel@sf-tec.de> <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> <44C143FA.9030808@pobox.com>
In-Reply-To: <44C143FA.9030808@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.904) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> The patch should contain ONE logical change.

Definitely yes. The problem is to figure out what "one" is.

I already posted what I considered one logical change in this case and 
why I did: It's an idiomatic makeover of k*alloc calls without change in 
functionality. What breaks my counting of "one" is that unwritten rules 
about preferred idioms (are said to) override written rules.
-- 
Stefan Richter
-=====-=-==- -=== =-==-
http://arcgraph.de/sr/
