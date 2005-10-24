Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVJXQiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVJXQiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVJXQiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:38:12 -0400
Received: from main.gmane.org ([80.91.229.2]:51394 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751146AbVJXQiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:38:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Some problems with 2.6.13.4
Date: Tue, 25 Oct 2005 01:27:15 +0900
Message-ID: <djj24d$ja8$1@sea.gmane.org>
References: <20051015122131.GG8609@schottelius.org> <43511AB1.3010608@g-house.de> <20051015154048.GK8609@schottelius.org> <20051015200245.GM12774@schottelius.org> <9a8748490510151322w25063287u567ecb698037fc4d@mail.gmail.com> <20051015203824.GN12774@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <20051015203824.GN12774@schottelius.org>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> Jesper Juhl [Sat, Oct 15, 2005 at 10:22:22PM +0200]:
> 
>>On 10/15/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
>>[snip]
>>
>>>Could we somehow debug this differently or do I have to install
>>>2.6.13.2 and 2.6.13.1, too? It would take simply hours until it is
>>>finished here.
>>>
>>
>>If you have another, faster, machine available you could build the
>>kernel(s) on that one.
> 
> Actually, one of my fastest machines is this one:
> 
> bruehe2# cat /proc/cpuinfo 
> [...]
> model name      : Pentium III (Katmai)
> cpu MHz         : 551.280
> [...]
> 
> And one, which has a not-so-good connection to me.
> 
> 
>>You don't have to build a kernel on the same
>>machine that is later supposed to run it.
> 
> 
> That's clear :-)
> 
> 
>>Also, if you have more than one machine (even if they are not
>>especially fast) then you can use distcc (http://distcc.samba.org/) to
>>distribute the build over multiple machines which can speed up a build
>>a great deal.
> 
> 
> distcc will fail here, because of different gccs and different distributions
> (ever tried to use gentoo and distcc in the same distcc-network? It's a real
> pain).
How come?
I am using distcc + ccache in default install with at least -j5 on my network of Gentoo machines.
And building a kernel with -j8 on 4 boxen (P4@2GHz each) is a snap.
Particularly pleasing to watch distccmon-gui :-D

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

