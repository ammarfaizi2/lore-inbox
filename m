Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWAAKD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAAKD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 05:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWAAKD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 05:03:29 -0500
Received: from main.gmane.org ([80.91.229.2]:46499 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932197AbWAAKD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 05:03:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Howto set kernel makefile to use particular gcc
Date: Sun, 01 Jan 2006 19:03:15 +0900
Message-ID: <dp89d4$u0i$1@sea.gmane.org>
References: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in> <200512301624.24229.chriswhite@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <200512301624.24229.chriswhite@gentoo.org>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris White wrote:
> On Friday 30 December 2005 16:04, Mukund JB. wrote:
> 
>>Dear Alessandro,
>>
>>Thanks for the reply.
>>What does that the make CC=<path_to_your_gcc_3.3> do?
>>Will it set my gcc default build configuration to gcc 3.3?
> 
> 
> Not Alessandro but,
> 
> CC sets the CC makefile variable.  When the kernel build system goes to 
> compile something, it doesn't call on gcc directly, but rather what the 
> variable CC is set to.  By setting it to your gcc 3.3 compiler, it will use 
> that instead.
> 
> 
>>I mean the general procedure is make bzImage; make modules....
>>How do I do these:
>>
>>Will I have to do it like:
>>	make bzImage cc=<gcc path>
> 
> 
> make CC=<gcc path> bzImage
> 
> note the case sensitivity, which tends to be somewhat of a pain for new *nix 
> users.

As I just stumbeled into a similar problem, I am going to ask here.

I know the "trick" of `make -j8 CC=distcc` and I always use it. But is there a way to hardwire
"CC=distcc" insie the Makefile? Just setting it there does not help it seems.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

