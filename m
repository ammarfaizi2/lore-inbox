Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbSKSPhR>; Tue, 19 Nov 2002 10:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSKSPhQ>; Tue, 19 Nov 2002 10:37:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63159 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266285AbSKSPhQ>; Tue, 19 Nov 2002 10:37:16 -0500
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Paul Larson <plars@linuxtestproject.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021119151028.GA13979@wotan.suse.de>
References: <200211190127.gAJ1RWg11023@linux.local.suse.lists.linux.kernel>
	<1037713044.24031.15.camel@plars.suse.lists.linux.kernel>
	<p73adk5vdra.fsf@oldwotan.suse.de>
	<1037719651.12118.7.camel@irongate.swansea.linux.org.uk> 
	<20021119151028.GA13979@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 16:12:23 +0000
Message-Id: <1037722343.12086.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 15:10, Andi Kleen wrote:
> It is because of the HZ=1000. See Jim Houston's mail on the same topic,
> he analyzed the failure.
> 
> Basically the current code cannot handle missing ticks properly on SMP and with
> the new 1ms tick it is much more likely that a timer interrupt gets lost.

Ok so add that to the other existing 2.5 timer handling bugs 8(

