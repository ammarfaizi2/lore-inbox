Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbULGXGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbULGXGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbULGXGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:06:10 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:49584 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261964AbULGXFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:05:35 -0500
Message-ID: <41B63738.2010305@cyberone.com.au>
Date: Wed, 08 Dec 2004 10:05:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
CC: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
References: <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz>
In-Reply-To: <20041207225932.GB12030@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lukas Hejtmanek wrote:

>On Wed, Dec 08, 2004 at 09:52:42AM +1100, Nick Piggin wrote:
>
>>You're using 2.6.9, right? 2.6.10 should be better in this regard.
>>
>
>Yes, 2.6.9. I'm waiting for 2.6.10 final.
>
>

OK. As a temporary fix for 2.6.9, increasing min_free_kbytes is the best
thing you can do.

If you are able to test 2.6.10-rc3, that would be nice.

>I tried also 2.6.10-rc1-mm3 but there was problably some memory corruption as
>/proc/loadavg displayed almost random load in range 0-2000.
>(according to http://undomiel1.ics.muni.cz/mrtg/load_1m.png)
>
>  
>

