Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbUCZEMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbUCZEMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:12:49 -0500
Received: from ns.suse.de ([195.135.220.2]:61674 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263921AbUCZEMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:12:48 -0500
Date: Fri, 26 Mar 2004 01:13:25 +0100
From: Andi Kleen <ak@suse.de>
To: John Lee <johnl@aurema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O(1) Entitlement Based Scheduler v1.1
Message-Id: <20040326011325.53275600.ak@suse.de>
In-Reply-To: <Pine.LNX.4.44.0403261053040.8120-100000@johnl.sw.oz.au>
References: <p73hdwda0qt.fsf@brahms.suse.de>
	<Pine.LNX.4.44.0403261053040.8120-100000@johnl.sw.oz.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 11:02:36 +1100 (EST)
John Lee <johnl@aurema.com> wrote:

> I'm glad to hear that the interactivity now works well for you, and that 
> it seems to be behaving itself over a period of days.

There seem to be still small issues, but I wasn't able to pinpoint them
to a scenario (I'm not even 100% sure they are related to the CPU scheduler, could
be IO elevator or VM too). Just thought I would mention them. Occassionally 
(very seldom, saw it two times yesterday) I have visible stalls (2-3s) of my xterms. 
It doesn't seem to be  related to direct visible background load (but i wasn't 
able yet to get a top up during such a stall) I don't remember these stalls from 
the non Entitlement kernel. They only happen very rarely so it could be 
something unrelated too. I know the report is probably too vague to be useful.

-Andi
