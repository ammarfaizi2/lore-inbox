Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVA0SQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVA0SQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVA0SQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:16:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:22739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262612AbVA0SQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:16:38 -0500
Date: Thu, 27 Jan 2005 10:16:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <41F92D2B.4090302@comcast.net>
Message-ID: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org>
 <41F92D2B.4090302@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, John Richard Moser wrote:
> 
> What the hell?

John. Stop frothing at the mouth already!

Your suggestion of 256MB of randomization for the stack SIMPLY IS NOT 
ACCEPTABLE for a lot of uses. People on 32-bit archtiectures have issues 
with usable virtual memory areas etc.

> Red Hat is all smoke and mirrors anyway when it comes to security, just
> like Microsoft.  This just reaffirms that.

No. This just re-affirms that you are an inflexible person who cannot see 
the big picture. You concentrate on your issues to the point where 
everybody elses issues don't matter to you at all. That's a bad thing, in 
case you haven't realized.

Intelligent people are able to work constructively in a world with many 
different (and often contradictory) requirements. 

A person who cannot see outside his own sphere of interest can be very 
driven, and can be very useful - in the "please keep uncle Fred tinkering 
in the basement, but don't show him to any guests" kind of way. 

I have a clue for you: until PaX people can work with the rest of the
world, PaX is _never_ going to matter in the real world. Rigidity is a
total failure at all levels. 

Real engineering is about doing a good job balancing different issues.

Please remove me from the Cc when you start going off the deep end, btw.

		Linus
