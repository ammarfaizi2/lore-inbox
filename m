Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRASGK4>; Fri, 19 Jan 2001 01:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130331AbRASGKr>; Fri, 19 Jan 2001 01:10:47 -0500
Received: from node10084.a2000.nl ([24.132.0.132]:65297 "EHLO caliban.org")
	by vger.kernel.org with ESMTP id <S130162AbRASGKc>;
	Fri, 19 Jan 2001 01:10:32 -0500
Date: Fri, 19 Jan 2001 07:10:30 +0100
From: Ian Macdonald <ianmacd@caliban.org>
Message-Id: <200101190610.f0J6AUK05724@caliban.org>
To: linux-kernel@vger.kernel.org
Subject: Re: pppoe in 2.4.0
In-Reply-To: <E14JRYM-0000Ns-00@plato.bork.org>
In-Reply-To: <E14JRYM-0000Ns-00@plato.bork.org>
Mail-Copies-To: never
X-OS: Linux 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2001 03:51:20 +0100 in caliban.linux.kernel, you wrote:

>Does anyone have pppoe working with 2.4.0?
>
>I'm running 2.4.0-ac9 with ppp and pppoe compiled into the kernel (I've
>tried with modules too)
>
>The pppd simply refuses to acknowlege the presence of ppp support in the
>kernel.
>The last release of pppd was in august 2000.  Was this before the ppp
>interface in the 
>kernel was overhauled?

Have you aliased the new module name to ppp?

I'm using pppd just for simple dial-up from home, but I needed to add
the following line to /etc/modules.conf before pppd would load the
correct module:

alias ppp ppp_async

However, I couldn't get PPP to work when I compiled it directly into
the kernel.

Ian
-- 
Ian Macdonald               | "Language shapes the way we think, and     
Senior System Administrator | determines what we can think about." -- B. 
Linuxcare, Inc.             | L. Whorf                                   
Support for the Revolution  |                                            
                            |                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
