Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbTIPPsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTIPPsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:48:45 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:7179 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261920AbTIPPso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:48:44 -0400
Message-ID: <3F6730F6.8040508@techsource.com>
Date: Tue, 16 Sep 2003 11:49:10 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
References: <20030916102113.0f00d7e9.skraw@ithnet.com>	 <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>	 <20030916153658.3081af6c.skraw@ithnet.com>	 <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>	 <20030916172057.148a5741.skraw@ithnet.com> <1063726141.10036.130.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> The kernel has no idea what you will do with given ram. It does try to
> make some guesses but you are basically trying to paper over hardware
> limits.


Maybe not what you WILL DO, but what you HAVE DONE.  Those tasks which 
have done the most DMA-requiring I/O could get preference for low 
memory.  No?

Yeah, I know.. show you the code.  :)

