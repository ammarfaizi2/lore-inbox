Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275096AbSITFxw>; Fri, 20 Sep 2002 01:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275117AbSITFxw>; Fri, 20 Sep 2002 01:53:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275096AbSITFxw>; Fri, 20 Sep 2002 01:53:52 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Date: Fri, 20 Sep 2002 06:01:47 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <amedkb$20g$1@penguin.transmeta.com>
References: <20020919191739.A25500@work.bitmover.com> <Pine.LNX.4.44L.0209192323530.1857-100000@imladris.surriel.com>
X-Trace: palladium.transmeta.com 1032501524 6765 127.0.0.1 (20 Sep 2002 05:58:44 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Sep 2002 05:58:44 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44L.0209192323530.1857-100000@imladris.surriel.com>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>On Thu, 19 Sep 2002, Larry McVoy wrote:
>> On Thu, Sep 19, 2002 at 11:01:33PM -0300, Rik van Riel wrote:
>
>> > So, where did you put those 800 MB of kernel stacks needed for
>> > 100,000 threads ?
>>
>> Come on, you and I normally agree, but 100,000 threads?  Where is the
>> need for that?
>
>I agree, it's pretty silly. But still, I was curious how they
>managed to achieve it ;)

You didn't read the post carefully.

They started and waited for 100,000 threads.

They did not have them all running at the same time. I think the
original post said something like "up to 50 at a time".

Basically, the benchmark was how _fast_ thread creation is, not now many
you can run at the same time. 100k threads at once is crazy, but you can
do it now on 64-bit architectures if you really want to.

		Linus
