Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSBIKz7>; Sat, 9 Feb 2002 05:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288851AbSBIKzj>; Sat, 9 Feb 2002 05:55:39 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:31941 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288850AbSBIKyN>; Sat, 9 Feb 2002 05:54:13 -0500
Message-Id: <200202082053.g18Krxja001427@tigger.cs.uni-dortmund.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Thu, 07 Feb 2002 23:09:09 +0100." <E16Ywj7-00016Y-00@starship.berlin> 
Date: Fri, 08 Feb 2002 21:53:59 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:
> On February 7, 2002 10:41 pm, Mike Touloumtzis wrote:
> > Adding configuration information to the kernel is a change to the status
> > quo, and has a cost.  The cost is small, but I'm unsympathetic to that
> > argument because many small convenience features, each with a small cost,
> > add up to a large cost.
> 
> The cost is *zero* if you don't enable the option, is this concept difficult
> for you?

It isn't zero: Somebody has to add the support, check/fix interactions with
other features, write documentation, keep the support and its documentation
up to date when stuff in the kernel changes, userland (and user) has to be
prepared (and checked that it works if the feature is present, and find
workarounds if it isn't), ...

It might be a small cost, but N * small gets big _very_ fast, and the value
is marginal at best in this case. There are many other such "small cost
features" with equally small value results that haven't been included. One
of the big reasons why I like Linux, BTW.
-- 
Horst von Brand http://counter.li.org # 22616
