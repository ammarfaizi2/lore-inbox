Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271442AbUJVQ2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271442AbUJVQ2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271444AbUJVQ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:28:11 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:50078 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S271442AbUJVQ2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:28:10 -0400
Message-ID: <41793519.1080500@tomt.net>
Date: Fri, 22 Oct 2004 18:28:09 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, root@chaos.analogic.com,
       Kasper Sandberg <lkml@metanurb.dk>,
       =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost> <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com> <200410221215.32597.gene.heskett@verizon.net>
In-Reply-To: <200410221215.32597.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Friday 22 October 2004 11:07, Richard B. Johnson wrote:
> 
>>while true ; do tar -xzf linux-2.6.9.tar.gz ; rm -rf linux-2.6.9 ;
>>vmstat ; done
> 
> 
> Stable, yes.  But only after about 3 or 4 iterations.  The first 3 
> rather handily used 500+ megs of memory that I did not get back when 
> I stopped it and cleaned up the mess.


It should get freed when something else needs it. Usually not before.
