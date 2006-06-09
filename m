Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbWFIQhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbWFIQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWFIQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:37:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51599 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965280AbWFIQhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:37:14 -0400
Message-ID: <4489A3B5.501@garzik.org>
Date: Fri, 09 Jun 2006 12:37:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Mike Snitzer <snitzer@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>	<4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>	<44899113.3070509@garzik.org>	<170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com> <m3odx2b86p.fsf@bzzz.home.net>
In-Reply-To: <m3odx2b86p.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Mike Snitzer (MS) writes:
> 
>  MS> precludes their ability to boot older kernels (steps can be taken to
>  MS> make them well aware of this). The "real world situation" you refer
>  MS> to, while hypothetically valid, isn't something informed
>  MS> ext3-with-extents users will _ever_ elect to do.
> 
> one who needs/wants to go back may get rid of extents by:
> a) remounting w/o extents option
> b) copying new-fashion-style files so that copies use blockmap
> c) dropping extents feature in superblock

More likely, they will just backup+restore rather than go through all that.

After leafing through a 50-page manual to match up kernel versions with 
ext3 features, to see which older kernels will (or won't) require all 
this work.

	Jeff



