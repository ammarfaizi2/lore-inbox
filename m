Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTDXV1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTDXV0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:26:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47111 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264506AbTDXVZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:25:57 -0400
Date: Thu, 24 Apr 2003 17:32:44 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Andrew Morton <akpm@digeo.com>,
       Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm4 & IRQ balancing
In-Reply-To: <Pine.LNX.4.50.0304231610030.27414-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.3.96.1030424173025.11734A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Zwane Mwaikambo wrote:

> On Wed, 23 Apr 2003, Bill Davidsen wrote:
> 
> > I like the idea of being able to tune the int processing with a user
> > program. I don't think I share your vision of making a user program part
> 
> You've actually been able to do this with echo(1) for a while, just not 
> 'automagically'
> 
> > of the kernel to allow diddling an interface which might be better getting
> > right the first time, and protecting against "features" being added.
> > Hopefully it will be minimalist, and may well benefit from a totally
> > different user program for various machine types.
> 
> The smp interrupt affinity interface hasn't changed for a while (since 
> inception?), we're only now deciding on where to put the autotune aspect 
> of it.

So the usermode program would not have to be part of kernel source as
previously stated, if I read that right, it just has to conform to a
standard. And everybody can write one and try to measure the difference it
makes.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

