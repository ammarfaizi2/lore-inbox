Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277104AbRJHTjD>; Mon, 8 Oct 2001 15:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277100AbRJHTiw>; Mon, 8 Oct 2001 15:38:52 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:59147 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S277105AbRJHTig>; Mon, 8 Oct 2001 15:38:36 -0400
Message-ID: <3BC20077.6020706@zk3.dec.com>
Date: Mon, 08 Oct 2001 15:37:27 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
In-Reply-To: <Pine.SGI.4.21.0110081207520.1003634-100000@spamtin.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to put in my $0.02 on this...  Compaq systems will span the range 
on this.  The current Wildfire^WGS Series systems have two levels - 
either "local" or "remote", which is just under 3:1 latency vs. local. 
This is all public knowledge, if you care to dig through all the docs. ;)

With the new EV7 systems coming out soon (next year?) every CPU has a 
switch and memory controller built in, so as you add CPUs (up to 64) you 
potentially add levels of latency.  I can't say what they are, but the 
numbers I've been given so far are _much_ better than that.  Just 
another data point. :)

  - Pete

