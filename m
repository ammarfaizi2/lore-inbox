Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTFBPms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTFBPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:42:48 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:6411 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S262525AbTFBPk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:40:57 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: Question about style when converting from K&R to ANSI C.
Date: Mon, 2 Jun 2003 15:54:21 +0000 (UTC)
Message-ID: <slrnbdmspd.23u.erik@bender.home.hensema.net>
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (torvalds@transmeta.com) wrote:
> In article <20030601132626.GA3012@work.bitmover.com>,
> Larry McVoy  <lm@bitmover.com> wrote:
>>On Sat, May 31, 2003 at 11:56:16PM -0600, Steven Cole wrote:
>>> Proposed conversion:
>>> 
>>> int foo(void)
>>> {
>>>    	/* body here */
>>> }	
>>
>>Sometimes it is nice to be able to see function names with a 
>>
>>	grep '^[a-zA-Z].*(' *.c
>>
>>which is why I've always preferred
>>
>>int
>>foo(void)
>>{
>>	/* body here */
>>}	
> 
> That makes no sense.

But it does. Type /^foo <enter> and you're at the function definition. At
least when using vi, which is the editor everybody's using, right? ;-)

Also, when in working in a (too) long function body, type ?^{ and you're
at the start of the function body.

> Do you write your normal variable definitions like
> 
> 	int
> 	a,b,c;
> 
> too? No you don't, because that would be totally idiotic.

Indeed, searching for ^a will fail. There's no reason whatsoever why you'd
declare your variables that way.

-- 
Erik Hensema <erik@hensema.net>
