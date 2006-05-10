Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWEJVL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWEJVL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWEJVL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:11:58 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:39750 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964861AbWEJVL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:11:57 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273787.17886.46.camel@localhost.localdomain>
	 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
	 <20060510162404.GR3570@stusta.de>
	 <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com>
	 <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 14:11:54 -0700
Message-Id: <1147295515.21536.168.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 16:44 -0400, Steven Rostedt wrote:
> On Wed, 10 May 2006, Daniel Walker wrote:
> 
> >
> > There's no code increase when you init something to itself . I could
> > convert all the instance of the warning, that I've investigated, to a
> > system like this . I think it would be a benefit so we could clearly
> > identify any new warnings added over time, and quiet the ones we know
> > aren't real errors .
> >
> > However, from all the responses I'd imagine a patch like this wouldn't
> > get accepted ..
> >
> 
> I really don't see why it couldn't be added.  What's the problem with it?
> 
> I mean, I see lots of advantages, and really no disadvantages.

We are in complete agreement .. The only disadvantage is maybe we cover
up and real error , but that seems pretty unlikely .. Maybe I'll get
motivated while your sleeping ..

Daniel


