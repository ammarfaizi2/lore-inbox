Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVGOQRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVGOQRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbVGOQRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:17:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26619 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261960AbVGOQRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:17:05 -0400
Subject: Re: RT and XFS
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Chinner <dgc@sgi.com>, Nathan Scott <nathans@sgi.com>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20050715102311.GA5302@elte.hu>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
	 <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu>
	 <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050714002246.GA937@frodo> <20050714135023.E241419@melbourne.sgi.com>
	 <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050715102311.GA5302@elte.hu>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 09:16:55 -0700
Message-Id: <1121444215.19554.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 12:23 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > PI is always good, cause it allows the tracking of what is high 
> > priority , and what is not .
> 
> that's just plain wrong. PI might be good if one cares about priorities 
> and worst-case latencies, but most of the time the kernel is plain good 
> enough and we dont care. PI can also be pretty expensive. So in no way, 
> shape or form can PI be "always good".

I don't agree with that. But of course I'm always speaking from a real
time perspective . PI is expensive , but it won't always be. However, no
one is forcing PI on anyone, even if I think it's good ..

Daniel

