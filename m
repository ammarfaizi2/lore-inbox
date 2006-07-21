Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWGUVRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWGUVRl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGUVRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:17:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16858 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751192AbWGUVRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:17:40 -0400
Message-ID: <44C1446A.7060008@pobox.com>
Date: Fri, 21 Jul 2006 17:17:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Panagiotis Issaris <takis@gna.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Fri, 21 Jul 2006, Panagiotis Issaris wrote:
>> Ah okay. Up until now, I thought it would be okay to change the style of
>> the code if it was listed in the CodingStyle document and in any other
>> cause should be left untouched as it would be left to the maintainers
>> personal preference. That's why I explicitly asked about the "if ((buf =
>> kmalloc(...)==NULL) -> buf = kmalloc(...); if (!buf)" type of changes.
>>
>> Ofcourse, I should have put cosmetic changes in a separate patch anyway.
> 
> At least Andrew seems to prefer cleaning up in the same patch. Anyway, I 
> don't think Jeff meant that you shouldn't do any cleanups, but that you 
> should try to respect the existing style as much possible.

Correct.

	Jeff



