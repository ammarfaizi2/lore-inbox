Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbULGWxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbULGWxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbULGWx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:53:29 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:4303 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261919AbULGWwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:52:49 -0500
Message-ID: <41B6343A.9060601@cyberone.com.au>
Date: Wed, 08 Dec 2004 09:52:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
CC: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
References: <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz>
In-Reply-To: <20041203121129.GC27716@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lukas Hejtmanek wrote:

>On Thu, Dec 02, 2004 at 04:18:39PM -0800, Andrew Morton wrote:
>
>>All I can say is "experiment with it".
>>
>>It might be useful to renice kswapd so that userspace processes do not
>>increase its latency.
>>
>
>Hmm, increasing the min free kb to 64MB and renicing kswapd to -8 seems to 
>solve the issue. However, for me it seems as not so good solution mainly because
>2.6.6-bk4 kernel is just ok without any tweeks.
>
>

You're using 2.6.9, right? 2.6.10 should be better in this regard.

