Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUBODzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUBODzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:55:33 -0500
Received: from relay.pair.com ([209.68.1.20]:41225 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263909AbUBODzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:55:31 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <402EECA4.4020703@kegel.com>
Date: Sat, 14 Feb 2004 19:51:00 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling
References: <402E8D1A.4000106@kegel.com> <20040214220726.GA13479@MAIL.13thfloor.at>
In-Reply-To: <20040214220726.GA13479@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
>>Wouldn't it be easier to use http://kegel.com/crosstool
>>which already builds good toolchains for just about every
>>CPU type?
> 
> 
> yeah Dan, I thought about that, and I guess I'll
> give that _another_ try soon, the reason I didn't
> choose that path, simply was, that I didn't want
> to compile the (g)libc, because I really do not 
> need it at all (kernel does not use/require that)
> and I didn't want to deal with that one too ...

Makes sense.  Simpler is better.

> btw, what archs did you verify? didn't find a 
> 'success' list or something like that, probably
> missed it somehow, anyway, currently I managed
> to compile binutils and gcc for:
> 
>  alpha, arm, cris, hppa/64, i386, ia64, m68k,
>  mips/64, ppc/64, s390, sh/4, sparc/64, v850,
>  x86_64 ...

I think I got most of those built except for hppa, ppc/64,
sparc/64, and v850.  (I've only run the gcc regression
tests on ppc405, ppc750, and sh4 so far, but hope to test more
later.)
Also, IBM seems to be using a variant of my script for ppc64.
- Dan

-- 
US citizens: if you're considering voting for Bush, look at these first:
http://www.misleader.org/
http://www.cbc.ca/news/background/arar/
http://www.house.gov/reform/min/politicsandscience/
