Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbVBDXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbVBDXTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbVBDWwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:52:35 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:49525 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266705AbVBDWST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:18:19 -0500
Message-ID: <4203F4A7.2010705@yahoo.com.au>
Date: Sat, 05 Feb 2005 09:18:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Terje_F=E5berg?= <terje_fb@yahoo.no>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: 2.6.10: kswapd spins like crazy
References: <20050204172618.51558.qmail@web51602.mail.yahoo.com>
In-Reply-To: <20050204172618.51558.qmail@web51602.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Fåberg wrote:
> Terje Fåberg <terje_fb@yahoo.no> skrev: 
> 
> 
>>I'll continue to do the same things I did yesterday
>>before kswapd started to spin. 
> 
> 
> Looks very good so far. I am unable to reproduce the
> bad kswapd behaviour with your patch, Nick.
> 
> To double-check I booted into the old kernel an hour
> ago and I _could_ reproduce the bad behaviour within a
> few minutes. 
> 
> Looks like your patch fixes it for my workload.
> 

OK that's good to know. At this stage it is only working
around the intermediate symptoms, and we might want a
different fix for 2.6.11...

So hopefully you'll be able to test a patch or two if
you get time.

Thanks,
Nick

