Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWFIQdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWFIQdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWFIQdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:33:01 -0400
Received: from [80.71.248.82] ([80.71.248.82]:31380 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1751455AbWFIQdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:33:00 -0400
X-Comment-To: "Mike Snitzer"
To: "Mike Snitzer" <snitzer@gmail.com>
Cc: "Jeff Garzik" <jeff@garzik.org>, "Alex Tomas" <alex@clusterfs.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Mingming Cao" <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>
	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>
	<4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>
	<44899113.3070509@garzik.org>
	<170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:33:18 +0400
In-Reply-To: <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com> (Mike Snitzer's message of "Fri, 9 Jun 2006 12:21:39 -0400")
Message-ID: <m3odx2b86p.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Mike Snitzer (MS) writes:

 MS> precludes their ability to boot older kernels (steps can be taken to
 MS> make them well aware of this). The "real world situation" you refer
 MS> to, while hypothetically valid, isn't something informed
 MS> ext3-with-extents users will _ever_ elect to do.

one who needs/wants to go back may get rid of extents by:
a) remounting w/o extents option
b) copying new-fashion-style files so that copies use blockmap
c) dropping extents feature in superblock

thanks, Alex
