Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUAOX4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbUAOX4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:56:17 -0500
Received: from pop.gmx.net ([213.165.64.20]:31420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263760AbUAOX4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:56:13 -0500
X-Authenticated: #4512188
Message-ID: <4007289A.3000005@gmx.de>
Date: Fri, 16 Jan 2004 00:56:10 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm2
References: <20040110014542.2acdb968.akpm@osdl.org>	<4003F34E.5080508@gmx.de>	<20040113095428.440762f7.akpm@osdl.org>	<400441BD.9020609@gmx.de>	<20040113111639.60b681d2.akpm@osdl.org>	<4004458C.5040000@gmx.de> <20040115152306.2c56d6e3.rddunlap@osdl.org>
In-Reply-To: <20040115152306.2c56d6e3.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> | > When the kernel prints that `badness' message it then prints a stack
> | > backtrace.  That's what we want.
> | 
> | But how to get that? When the machine locks up, I don't see anything 
> | written and only *sometimes* I got above message in the log  -whcih I 
> | can only see afterwards. But there is nothing else realted to it in the 
> | log...
> 
> (I didn't see any replies to this...)
> 
> The usual answer is to use a serial console to log the kernel messages,
> but not everyone has that option available to them.
> 
> Depending on your system, you might be able to use kmsgdump to
> capture the final kernel messages to a floppy disk (if you have a
> "legacy" type floppy).  If you are interested in trying that,
> the kmsgdump patch is available at
>   http://developer.osdl.org/rddunlap/kmsgdump/

Sounds interesting. I will give it a try. But according to your other 
post, it seems to have problems with APIC, so just the case which seems 
to make problems for me...

Prakash
