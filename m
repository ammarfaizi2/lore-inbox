Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbTFYXXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbTFYXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:23:53 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:18447 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S265000AbTFYXXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:23:52 -0400
Message-ID: <3EFA32C6.5030303@techsource.com>
Date: Wed, 25 Jun 2003 19:39:50 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Edward Tandi <ed@efix.biz>, joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466
References: <BB1F47F5.17533%kernel@mousebusiness.com>	 <200306251501.14207.jbriggs@briggsmedia.com>	 <1056567378.31260.9.camel@wires.home.biz> <3EFA2939.2060005@techsource.com> <1056583075.31265.22.camel@wires.home.biz> <3EFA2F97.5000705@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timothy Miller wrote:

> It is my understanding that the registered memory requirement has 
> nothing to do with SMP but instead with the amount of memory you have. 
> The more memory chips you have, the greater the signal loading on the 
> memory bus.  More input drivers means more capacitance which means you 
> need your output drivers to put out data sooner (relative to the clock 
> edge, so registered delays by one clock) and stronger (greater drive 
> strength).
> 
> In an SMP system (besides NUMA), multiple processors will talk to the 
> same memory through a shared memory controller (like in a Northbridge), 
> so although there are multiple processors, there is still only one 
> memory bus.  Pulling off one CPU isn't going to change that situation.
> 

Here's a URL:

http://www.simmtester.com/PAGE/memory/memfaq.asp?cat=6&subcat=&tableView=detail&faqId=15

