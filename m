Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbTCIW4e>; Sun, 9 Mar 2003 17:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbTCIW4d>; Sun, 9 Mar 2003 17:56:33 -0500
Received: from smtp-102.nerim.net ([62.4.16.102]:44302 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S262658AbTCIW4c>;
	Sun, 9 Mar 2003 17:56:32 -0500
Message-ID: <3E6BC90D.3080604@inet6.fr>
Date: Mon, 10 Mar 2003 00:06:53 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.64bk4] Weird problem with 2 PCs
References: <200303091749.40739.spstarr@sh0n.net>
In-Reply-To: <200303091749.40739.spstarr@sh0n.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:

>I don't have an oops/panic to give because the box won't dump one on this 
>issue.
>
>I have two PCs, an A7M266-D Athlon MP 2000+ and an IBM 300PL 6892-N2U PIII 
>(Katmai) 450Mhz.  If I leave the IBM machine on for a few hours or so, it's 
>idle and just handling my mail/dns.  The problem happens when I turn on the 
>A7M266-D the other box locks up and reboots (due to panic=80). ksyslog/klogd 
>aren't dumping any oopes to my logfile so I'm unable to capture the bug.
>
>1. The PCs are connected via a router to my network.
>
>2. The PCs are connected via serial port together (possibly causing the oops 
>with interrupts?)
>  
>

Doesn't seem like a software pb to me...
Are the 2 PCs grounded ?
If you own a voltmeter, remove the serial link and try measuring the 
tension between the ground pins of the 2 serial interfaces you use for 
your serial link. If my guess is right your IBM (or its serial port) is 
not correctly grounded and might act like an accumulator that discharges 
itself when the other PC is switched on !

>Note, when I turn off and on the A7M266-D the IBM will not panic. It's only 
>when the IBM is powered on for a few hours (if thats any help in narrowing 
>down things).
>  
>

99,9% chances of an hardware problem.

LB.

