Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270508AbSISIS2>; Thu, 19 Sep 2002 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270509AbSISIS2>; Thu, 19 Sep 2002 04:18:28 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:31887 "EHLO
	starship") by vger.kernel.org with ESMTP id <S270508AbSISIS2>;
	Thu, 19 Sep 2002 04:18:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [chatroom benchmark version 1.0.1] Results
Date: Thu, 19 Sep 2002 10:23:33 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020919080602.2986.qmail@linuxmail.org>
In-Reply-To: <20020919080602.2986.qmail@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rwaz-0000vY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought I'd bounce this one over to Andrew as a warm-n-fuzzy.
There's also some kind of hint that preemption improves throughput
here.

On Thursday 19 September 2002 10:06, Paolo Ciarrocchi wrote:
> What I did:
> Boot in single mode with apm off
> ./chat_s 127.0.0.1 &
> ./chat_c 127.0.0.1 30 1000 9999
> 
> And now the results:
> 2.4.19-ck7.results:Average throughput : 55928 messages per second
> 2.4.19.results:Average throughput : 44851 messages per second
> 2.5.33.results:Average throughput : 59522 messages per second
> 2.5.34.results:Average throughput : 62941 messages per second
> 2.5.36.results:Average throughput : 60858 messages per second
> 
> 2.4.19-ck7 is preemption ON
> 2.5.33 and 2.5.34 are preemption ON
> 2.5.36 is preemption OFF (Robert, 2.5.36 with preemption ON oops at boot)

-- 
Daniel
