Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbSIZBjV>; Wed, 25 Sep 2002 21:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSIZBjV>; Wed, 25 Sep 2002 21:39:21 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:36545 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261653AbSIZBjU> convert rfc822-to-8bit; Wed, 25 Sep 2002 21:39:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: nf@hipac.org
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification for Netfilter
Date: Thu, 26 Sep 2002 03:44:26 +0200
User-Agent: KMail/1.4.3
References: <200209260041.56374.nf@hipac.org> <200209260238.06400.nf@hipac.org> <20020925.173728.08323077.davem@redhat.com>
In-Reply-To: <20020925.173728.08323077.davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209260344.26814.nf@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Seriously, just sit tight with your work, and once the stackable
> route stuff is done, you can look into applying your algorithms
> to the new flow cache.

Sorry, we are a bit confused of the formulation "adding the algorithmus to the 
new flow cache"
Why to the flow cache? What exaclty is the job of this flow cache?
Does the job go beyond caching recently "lookup results"?
What happens if the flow cache doesn't have a certain lookup result in the 
cache yet?
We mean, how is the packet classification solved then?
Is it right, that the code will then use a linear search algorithm and compare 
the packet with each rule sequentially until a rule is found that matches all 
relevant fields?

Our algorithm does not implement some kind of cache. Our algorithm is actually 
a replacement for that linear search algorithm. Our algorithm implements an 
advanced approach to the packet classification problem itself.

the nf-hipac team
	Michael Bellion, Thomas Heinz

