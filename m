Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTKYBqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 20:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTKYBqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 20:46:52 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:44238 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261841AbTKYBqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 20:46:51 -0500
Message-ID: <3FC2B487.8080709@cyberone.com.au>
Date: Tue, 25 Nov 2003 12:46:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generalise scheduling classes
References: <20031117021511.GA5682@averell> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au> <bpu1sp$vil$1@gatekeeper.tmr.com>
In-Reply-To: <bpu1sp$vil$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <3FC0A0C2.90800@cyberone.com.au>,
>Nick Piggin  <piggin@cyberone.com.au> wrote:
>
>| We still don't have an HT aware scheduler, which is unfortunate because
>| weird stuff like that looks like it will only become more common in future.
>
>The idea is hardly new, in the late 60's GE (still a mainframe vendor at
>that time) was looking at two execution units on a single memory path.
>They decided it would have problems with memory bandwidth, what else is
>new?
>

I don't think I said new, but I guess they (SMT, NUMA, CMP) are newish
for architectures supported by Linux Kernel. OK NUMA has been around for
a while, but the scheduler apparently doesn't work so well for atypical
new NUMAs like Opteron.


