Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268426AbTBYWcU>; Tue, 25 Feb 2003 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268428AbTBYWcU>; Tue, 25 Feb 2003 17:32:20 -0500
Received: from main.gmane.org ([80.91.224.249]:59089 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S268426AbTBYWcT>;
	Tue, 25 Feb 2003 17:32:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: as vs cfq vs deadline
Date: Tue, 25 Feb 2003 16:42:32 -0600
Message-ID: <b3grga$7oh$1@main.gmane.org>
References: <20030223164924.16952.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:

> Hi all,
> I've run a 'let's check if it does not skip frames test'.
> kernel is 2.5.62-mm2.
> 
> ** How I performed the test **
> startx
> I've opened to xterminal
> 
> terminal1
> [test@frodo test]$ glxgears
> 
> terminal2
> ./dbench 16
> 
> Following the results:
> 

<snip>

> I can not see any difference in the results above.
> 
> I guess the test I've run it is not a good test, isn't it ?

a) you're only looking at glxgears average framerate, so you've not measured
whether it drops frames at all, and 
b) glxgears does no disk i/o at all, so it shouldn't care a bit what the I/O
scheduelr is doing (other than how much cpu the kernel is using, which
shouldn't be all that high)

> Comments/suggesiontions ?
> 
> Ciao,
> Paolo
> 


