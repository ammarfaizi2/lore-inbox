Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTH0P04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTH0P04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:26:56 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62699 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263437AbTH0P0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:26:55 -0400
Message-ID: <3F4CCB26.3020408@ccs.neu.edu>
Date: Wed, 27 Aug 2003 11:15:50 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030819
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030826122621.GB3140@malvern.uk.w2k.superh.com> <20030827140121.GA1973@mail.jlokier.co.uk>
In-Reply-To: <20030827140121.GA1973@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

<SNIP>

> I expect it to do the first of these which is applicable:
> 
> 	- raise SIGILL on Pentium and earlier Intel CPUs
> 	- raise SIGILL on non-Intel CPUs which don't have the SEP capability
> 	- raise SIGSEGV on Pentium Pro CPUs
> 	- raise SIGSEGV on Pentium II CPUs with model == 3 and stepping < 3
> 	- raise SIGSEGV on 2.4 kernels
> 	- exit with status 0 on 2.6 kernels
> 
> Enjoy,
> -- Jamie

As expected I get a SIGILL on P166 with 2.4.22

-sb
-----------------------------------------------
The price of freedom? Ask your Senator how much
the RIAA gave him for his Lexus.



