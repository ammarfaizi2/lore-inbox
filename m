Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTLOVmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTLOVmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:42:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32503 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264123AbTLOVme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:42:34 -0500
Message-ID: <3FDE2AC6.30902@mvista.com>
Date: Mon, 15 Dec 2003 13:42:30 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl> <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com> <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Fri, 12 Dec 2003, George Anzinger wrote:
> 
> 
>>Having had cause to try and figure out all this, I vote for the following being 
>>included in the source somewhere...
> 
> 
>  Hmm, you could have simply asked... ;-)  Anyway, an inclusion is doable,
> I guess.
> 

I suspect I did, but most likey the wrong place.  In any case, I would like to 
think that "read the source, Luke" is the right answer.

So, while I am in the asking mode, is there a simple way to turn off the PIT 
interrupt without changing the PIT program?  I would like a way to stop the 
interrupts AND also stop the NMIs that it generates for the watchdog.  I suspect 
that this is a bit more complex that it would appear, due to how its wired.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

