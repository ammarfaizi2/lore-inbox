Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTFAOJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbTFAOJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:09:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:50448 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264632AbTFAOJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:09:20 -0400
Date: Sun, 1 Jun 2003 16:22:37 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Larry McVoy <lm@work.bitmover.com>, Willy Tarreau <willy@w.ods.org>,
       Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601142237.GA11378@alpha.home.local>
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <20030601134942.GA10750@alpha.home.local> <20030601140602.GA3641@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601140602.GA3641@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 07:06:02AM -0700, Larry McVoy wrote:
 
> It may be just what you are used to but I also find that when reading lots
> of code it is nice to have it look like

Well, I think it's the _main_ reason for most of us coding this way. When
you're used to read it this way, it seems completely normal, and other methods
seem strange. I even used to put the opening brace on the same line as the
function, because I don't like having a line with a single char, I find it a
wast of screen space. But the kernel coding style slowly makes me move forward
to its method.

> return type
> function_name(args)
> 
> because the function_name() stands out more, it's always at the left side so
> I tend to parse it a little more quickly.

I can agree with you on this point. It's only that since I'm not used to read
it this way, I have to make an effort finding the type, even if it's just above.
I will try to use this method just to see if I can feel comfortable with it.

> Don't get me wrong, I'm not arguing that you should go reformat all your
> code (I tend to agree with Linus, if it's not your code, don't stick your
> fingers in there just because you want to reformat it).  All I'm doing
> is trying to understand why in this instance did Linux diverage from 
> common practice.  

I just found through google that C programs are indeed formated as you say,
but C++ programs have the type on the same line as the name. So if this
comes from this origin, we'll be able to say that Linux contains no C++ except
its formating :-)

Cheers,
Willy

