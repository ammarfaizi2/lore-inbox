Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVGTBCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVGTBCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVGTBCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 21:02:38 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:5602 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261625AbVGTBCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 21:02:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: dwalker@mvista.com
Subject: Re: Interbench real time benchmark results
Date: Wed, 20 Jul 2005 11:04:48 +1000
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
References: <200507200816.11386.kernel@kolivas.org> <20050719223216.GA4194@elte.hu> <1121819037.26927.75.camel@dhcp153.mvista.com>
In-Reply-To: <1121819037.26927.75.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201104.48249.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2005 10:23 am, Daniel Walker wrote:
> On Wed, 2005-07-20 at 00:32 +0200, Ingo Molnar wrote:
> >  - networking is another frequent source of latencies - it might make
> >    sense to add a workload doing lots of socket IO. (localhost might be
> >    enough, but not for everything)
>
> The Gnutella test?

I've seen some massive latencies on mainline when throwing network loads from 
outside, but with my limited knowledge I haven't found a way to implement 
such a thing locally. I'll look at this gnutella test at some stage to see 
what it is and if I can adopt the load within interbench. Thanks for the 
suggestion.

Cheers,
Con
