Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137050AbREKFbM>; Fri, 11 May 2001 01:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137048AbREKFbC>; Fri, 11 May 2001 01:31:02 -0400
Received: from [203.143.19.4] ([203.143.19.4]:8721 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S137049AbREKFat>;
	Fri, 11 May 2001 01:30:49 -0400
Date: Thu, 10 May 2001 16:51:17 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Helge Hafting <helgehaf@idb.hist.no>,
        Tobias Ringstrom <tori@tellus.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <20010507210229.A7724@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0105101649220.283-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, J . A . Magallon wrote:

> 
> On 05.07 Helge Hafting wrote:
> >
> > !0 is 1.  !(anything else) is 0.  It is zero and one, not
> > zero and "non-zero".  So a !! construction gives zero if you have
> > zero, and one if you had anything else.  There's no doubt about it.
> > >
> 
> Isn't this asking for trouble with the optimizer ? It could kill both
> !!. Using that is like trusting on a certain struct padding-alignment.
> 

It isn't, or rather it can't. Because !!x is not x unless x is one or
zero.

Anuradha

