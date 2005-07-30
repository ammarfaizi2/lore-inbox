Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVG3Cjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVG3Cjj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVG3Cjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:39:39 -0400
Received: from fsmlabs.com ([168.103.115.128]:65487 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262718AbVG3Cji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 22:39:38 -0400
Date: Fri, 29 Jul 2005 20:44:48 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: mkrufky@m1k.net, frank.peters@comcast.net, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
In-Reply-To: <20050728225433.6dbfecbe.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507292043210.14714@montezuma.fsmlabs.com>
References: <20050624113404.198d254c.frank.peters@comcast.net>
 <42BC306A.1030904@m1k.net> <20050624125957.238204a4.frank.peters@comcast.net>
 <42BC3EFE.5090302@m1k.net> <20050728222838.64517cc9.akpm@osdl.org>
 <42E9C245.6050205@m1k.net> <20050728225433.6dbfecbe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Andrew Morton wrote:

> Michael Krufky <mkrufky@m1k.net> wrote:
> >
> >  Sadly, I must report that yes, the problem still intermittently occurs 
> >  in 2.6.13-rc4 :-(  I'm the one that tested on the Shuttle FT61 
> >  Motherboard.  Never has a problem in windows and never in 2.6.11 and 
> >  earlier.
> > 
> >  I first noticed this problem sometime during 2.6.12-rc series.
> 
> Sigh.  I think it would help if you could generate a new report, please.
> 
> We need a super-easy way for people to do bisection searching.

ketchup is extremely handy for narrowing it down to a release, you then 
pray that the bug is in the -mm tree first so that it's easier to check 
all the patches individually ;)
