Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTJWArx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 20:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTJWArx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 20:47:53 -0400
Received: from ssa8.serverconfig.com ([209.51.129.179]:61608 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S261397AbTJWAru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 20:47:50 -0400
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: Dave Jones <davej@redhat.com>
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Date: Wed, 22 Oct 2003 19:47:45 +0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info> <20031023001547.GA18395@redhat.com>
In-Reply-To: <20031023001547.GA18395@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310221947.45996.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Already done for 2.6

Version 2.6 is still in beta.  Besides, this should have been done years ago 
before 2.6 existed.

> Last time I looked these made absolutely no difference to performance
> due to the only differences being on FP code.

So what?  Some other kernel developer -- like a module/driver developer, a 
real-time systems developer, a simulations developer, or just some guy 
messing around (read: student) -- might really want or even need those 
specific optimizations.

Isn't this whole free-as-in-freedom software thing about giving developers 
and end-users options they wouldn't otherwise have under closed source 
alternatives?  In that spirit, shouldn't developers have the option of 
optimizing for those specific processors?

And don't give me this crap that being open source means I can do it myself.  
The fact is that most people can't make the changes themselves.  Then, 
instead of chosing between an operating system they like and an operating 
system they hate, people end up choosing between an operating system they 
hate and an operating system they really hate.

This is one of the reasons why I've never contributed to any open source 
project: the my-way-or-the-highway attitude of the existing developer base 
makes attempts for newbies to get inside an invintation for unnecessary 
pain.

Unless there's some hidden section of makefile code I don't know about, you 
can count the number of lines that would have to be changed to meet my 
request on the fingers of one of your hands.  If you don't make the change, 
I will consider it conclusive proof that the whole free-as-in-freedom is 
really just free-as-in-beer.

Joseph D. Wagner
