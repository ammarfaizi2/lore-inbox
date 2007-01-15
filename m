Return-Path: <linux-kernel-owner+w=401wt.eu-S1751149AbXAOSAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXAOSAr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXAOSAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:00:47 -0500
Received: from mail.tmr.com ([64.65.253.246]:44832 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbXAOSAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:00:46 -0500
Message-ID: <45ABC1A2.90109@tmr.com>
Date: Mon, 15 Jan 2007 13:02:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: theSeinfeld@users.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
Subject: Re: allocation failed: out of vmalloc space error treating and  
 VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>	<200701100023.39964.theSeinfeld@users.sf.net>	<tkrat.c0a43c7c901c438c@s5r6.in-berlin.de> <1168802934.3123.1062.camel@laptopd505.fenrus.org>
In-Reply-To: <1168802934.3123.1062.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2007-01-14 at 20:19 +0100, Stefan Richter wrote:
>> On 10 Jan, Peter Antoniac wrote:
>> [...]
>>> Problem is: how to get the VMALLOC_RESERVED value for the kernel that is 
>>> running? I couldn't find any standard way to do that (something to apply to 
>>> GNU Linux and the like). All the things I could get were the default value 
>>> being 128MiB :) and that is it. Now, I could just put 128, but what if 
>>> somebody changes that, or in some new distro suddenly decides to make it 
>>> different? Even worse, what if it is an old kernel with 64 setting?
>> [...]
>>
>> Maybe somebody at LKML has answers?
> 
> vmalloc space is limited; you really can't assume you can get any more
> than 64Mb or so (and even then it's thight on some systems already); it
> really sounds like vmalloc space isn't the right solution for your
> problem whatever it is (context is lost in the quoted mail)...
> can you restate the problem to see if there's a better solution
> possible?
> 
I've used vmalloc in the past, and not had a problem, but it is a fair 
question, how do you find out how much space is available? Other than a 
binary vmalloc/release loop.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
