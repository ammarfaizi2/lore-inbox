Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSLTTVd>; Fri, 20 Dec 2002 14:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSLTTVc>; Fri, 20 Dec 2002 14:21:32 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:54533 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264943AbSLTTV3>; Fri, 20 Dec 2002 14:21:29 -0500
Date: Fri, 20 Dec 2002 19:29:29 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50] Keyboard dying
In-Reply-To: <200212151007.gBFA7itN001447@ibe.miee.ru>
Message-ID: <Pine.LNX.4.44.0212201928170.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >        After some X <-> back switches keyboard stops doing anything.
> > >        2.5.50 + preempt enabled, X 4.2.1-debian-unstable.
> > >
> > > showkey started using gpm tells that the keys actually are pressed and
> > > processed by the kernel.
> > > Although even alt+sysrq+whatever do not make any effect.
> > 
> > Can you disable preempt and see if you have the same problem.
> 
>   After some days of testing all seems fine. So preempt must be the trigger.

The VT console system is totally not preempt safe. Everything is global. 
I finished most of the work to make a preempt safe VT console system but 
that will not go in this developement cycle. 

