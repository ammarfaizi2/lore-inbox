Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUFOUOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUFOUOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUFOUOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:14:32 -0400
Received: from wilma.widomaker.com ([204.17.220.5]:8205 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S265923AbUFOUNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:13:20 -0400
Date: Tue, 15 Jun 2004 10:55:46 -0400
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: why swap at all?
Message-ID: <20040615145545.GI6218@widomaker.com>
References: <40BF3250.9040901@tmr.com> <S265663AbUFDHTq/20040604071946Z+537@vger.kernel.org> <40C0AC9D.1020805@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0AC9D.1020805@tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, 04 Jun 2004 @ 13:08 -0400, Bill Davidsen said:

> But I fail to make my point... I want to limit how much memory is used 
> for i/o buffers, cache, or anything else which will produce memory 
> pressure of my programs. 

I would love to be able to limit this kind of memory use.

I've always liked how BSD works in this area, never using over a certain
amount.

I find the Linux behavior of using all memory for things like
buffercache is less than optimal.  While there are situations where it
helps, there are a great many where it hurts.

I frequently do work which fills memory with data I'll never use again,
and it makes things slow.

Desktop work tends to do this kind of thing as well.

> That's what would be nice with tuning, the admin can optimize what is 
> important on that system. I am usually happy with what the system does 
> on i/o, but I want my 500MB or so of programs to stay resident in a 2GB 
> machine, and if that adds a ms or two to i/o I can live with it, so that 
> when I change windows it happens now, not eventually. And I bet there 
> are a lot of others who would like better response to focus changes aswell.

Not only that, but I wish certain bits of code could be locked into
memory.  Generally any code and data associated with the user interface
should always be there.

It's annoying when a menu in X takes ten seconds of swapping to appear.

-- 
shannon "AT" widomaker.com -- [javalin: an unwieldy programming weapon used
to stab a software project through the heart until dead]
