Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUFRSo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUFRSo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266729AbUFRSko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:40:44 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:32505 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S266147AbUFRSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:35:59 -0400
Message-ID: <40D33608.5000201@ThinRope.net>
Date: Sat, 19 Jun 2004 03:35:52 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
References: <200406181611.37890.andrew@walrond.org> <200406181721.47968.andrew@walrond.org> <40D31EA6.5030207@ThinRope.net> <200406181846.22150.andrew@walrond.org>
In-Reply-To: <200406181846.22150.andrew@walrond.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> On Friday 18 Jun 2004 17:56, Kalin KOZHUHAROV wrote:
> 
>>However, isn't that supposed to be filed with iptables (@netfilter.org)?
> 
> My original mail was addressed to netfilter@lists.netfilter.org, and cc'ed to 
> lkml
What can I say :-| NB to myself: Kalin, _DO_ read Subject, To, CC for all post in LKML
Sorry.

So, I was poking around for the last hour or so and found quite a few things.
It seems that most people prefer to build iptables against linux-headers supplied by their distribution and not the running kernel. I agreed on that. Although a few distributions may lag behind updating linux-headers, it should be the preferred way as it is stable.

I just downloaded and compiled iptables-1.2.10 against my  system headers using `make KERNEL_DIR=/usr` (haven't actually run it, but it should work).

Well of course if you want the latest-and-greatest extensions, you might try to compile against your running kernel, but you are on your own (with help from netfilter.org).

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/

