Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUBWG34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 01:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbUBWG34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 01:29:56 -0500
Received: from everest.2mbit.com ([24.123.221.2]:54980 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261837AbUBWG3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 01:29:54 -0500
Message-ID: <40399D9E.9000703@greatcn.org>
Date: Mon, 23 Feb 2004 14:28:46 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: David Weinehall <david@southpole.se>
CC: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se> <1075223456.5219.1.camel@midux> <40172C5E.3090201@lovecn.org> <20040128033755.GC16675@khan.acc.umu.se>
In-Reply-To: <20040128033755.GC16675@khan.acc.umu.se>
X-Scan-Signature: 418ef03ee7cfcfbc6c4f32dd4f25d104
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: about 2.0 cleanup or adaption
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

> On Wed, Jan 28, 2004 at 03:28:30AM +0000, Coywolf Qi Hunt wrote:
> 
>>Recently I just have such an idea that is to port the 2.0.39 to let it 
>>be compiled with my gcc 2.95.4 or any
>>other latest gcc. At the same time,  also make it remain compliant to 
>>gcc 2.7.2.1. ( I can't find 2.7.2.1, only 2.7.2.3
>>on the ftp)  Is this work worth while?
> 
> 
> Well, for sure it's quite a demanding task, since, if I remember
> correctly, the module-code uses some nasty internal gcc-knowledge to
> generate code, that simply doesn't work with later versions of gcc.
> It might be that I remember this incorrectly though.

I think the first problem is to adapt the some inline assembly code to 
new style for the strict clobber list issue in recent gcc. If it is 
worthwhile, I'd like to do the work.

> 
> It would be interesting, yes, but only if it can be proved to some
> degree that no new bugs are introduced.
> 
> My aim for 2.0.41 is to make it a cleanup-release; remove warnings, tidy
> up a little source-code mess, kill dead code, fix typos etc.
> 
> 
> Regards: David Weinehall


I'm not sure of the defined but never used code. There's a lot.
How to deal with them?



	Coywolf

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

