Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbULPUku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbULPUku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbULPUj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:39:28 -0500
Received: from terminus.zytor.com ([209.128.68.124]:46727 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262013AbULPUie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:38:34 -0500
Message-ID: <41C1F20E.2030903@zytor.com>
Date: Thu, 16 Dec 2004 20:37:34 +0000
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>	 <1101976424l.5095l.0l@werewolf.able.es>	 <1101984361.28965.10.camel@tara.firmix.at>	 <cpkc5i$84f$1@terminus.zytor.com>  <1102972125l.7475l.0l@werewolf.able.es>	 <1103158646.3585.35.camel@localhost.localdomain>	 <41C0F67D.4000506@zytor.com> <1103203426.3804.16.camel@localhost.localdomain>
In-Reply-To: <1103203426.3804.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-12-16 at 02:44, H. Peter Anvin wrote:
> 
>>Yes, but there is also no really big deal compiling C code with a C++ 
>>compiler.  Yes, it was a disaster in 0.99.14, but that was 10 years ago.
> 
> 
> g++ is still much slower. We don't know how many bugs it would show up
> in the compiler and tools either, especially on embedded platforms.
> Finally the current kernel won't go through a C++ compiler because we
> use variables like "new" quite often.

-Dnew=_New, problem solved.

I'm not in any way advocating compiling with g++ exclusively, but it 
would be nice to be *able to* for bugchecking.  It would be an 
interesting experiment, of nothing else.  I suspect it'd require some 
minor code tweaks and turn up a small handful of bugs right off the bat.

	-hpa

