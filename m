Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVF2QF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVF2QF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVF2QF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:05:27 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61316 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261500AbVF2QFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:05:21 -0400
Date: Wed, 29 Jun 2005 12:04:47 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Denis Vlasenko <vda@ilport.com.ua>, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <20050629155436.GD2130@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0506291158590.22775@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
 <200506291714.32990.vda@ilport.com.ua> <20050629142317.GB2130@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0506291046020.22775@localhost.localdomain>
 <20050629151053.GC2130@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0506291141090.22775@localhost.localdomain>
 <20050629155436.GD2130@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Jun 2005, Jörn Engel wrote:

> Ok, before even more people get confused - I was joking.  Simple code
> is obviously a good thing to have.  Not thinking about code, well...

Your first part seemed half joking and half serious, so I responded with a
more serious answer, just to make sure that others don't think  I write
code like this:

spin_lock_irqsave(lock1,flags1);
spin_lock_irqsave(lock2,flags2);
spin_lock_irqsave(lock3,flags3);

Which would just be really silly!  But you never know ;-)


>
> ... but it appears as if you got the joke.
>

What do you mean?  My professor has shown me the light and LinuxSmallTalk
is the future.

-- Steve

