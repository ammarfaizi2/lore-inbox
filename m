Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbTICPWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTICPWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:22:46 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:19148 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263659AbTICPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:22:38 -0400
Date: Wed, 03 Sep 2003 08:10:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <25950000.1062601832@[10.10.2.4]>
In-Reply-To: <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk>
References: <E19uQsT-0007mk-00@calista.inka.de> <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> multi node yes, numa not much and where numa-like systems are being used
> they are being used for message passing not as a fake big pc. 
> 
> Numa is valuable because
> - It makes some things go faster without having to rewrite them
> - It lets you partition a large box into several effective small ones 
>   cutting maintenance
> - It lets you partition a large box into several effective small ones
>   so you can avoid buying two software licenses for expensive toys
> 
> if you actually care enough about performance to write the code to do
> the job then its value is rather questionable. There are exceptions as
> with anything else.

The real core use of NUMA is to run one really big app on one machine, 
where it's hard to split it across a cluster. You just can't build an 
SMP box big enough for some of these things.

M.

