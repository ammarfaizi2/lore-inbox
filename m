Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282339AbRKXBqh>; Fri, 23 Nov 2001 20:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282338AbRKXBq1>; Fri, 23 Nov 2001 20:46:27 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:28800 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282337AbRKXBqU>;
	Fri, 23 Nov 2001 20:46:20 -0500
Message-ID: <3BFEFBE6.942D784F@pobox.com>
Date: Fri, 23 Nov 2001 17:46:14 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-ll-preempt-tux2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <Pine.LNX.4.33.0111231257070.5254-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> following Trond's suggestions i reverted the dec_and_lock hacks from the
> TUX patch. Could you try the latest 2.4.15-B2 patch:
>
>         http://redhat.com/~mingo/TUX-patches/tux2-full-2.4.15-pre9-B2.bz2
>
> (it will apply to 2.4.15-final just as well) Does this solve the symbol
> export problem?

Yes, it's good - no more symbol problems.

Currently running 2.4.15 plus the following:

 - the al viro fs patches
 - tux2-full-2.4.15-pre9-B2
 - 2.4.15-pre7-1-low latency.patch
 - preempt-kernel-rml-2.4.15-pre9-1.patch

tux is still insanely fast, I'll give it the dbench
test and the xmms and wolfenstein tests later -

;-)

cu

jjs



