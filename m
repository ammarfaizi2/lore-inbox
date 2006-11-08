Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161742AbWKHWWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161742AbWKHWWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161745AbWKHWWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:22:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161742AbWKHWWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:22:15 -0500
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
From: Arjan van de Ven <arjan@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 23:22:11 +0100
Message-Id: <1163024531.3138.406.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There's no shortage of issues that need fixing, but since we keep
> merging new stuff, a lot of bugfixing energy gets spend on the new
> cool stuff instead of fixing up any other issues we have.

but if you do this you just end up with a bigger backlog so that the
next one will even be more unstable due to a extreme high change rate.


> Coverity has, as of this writing, identified 728 issues in the current
> kernel. Sure, some of those have already been identified as false or
> ignorable issues, but many are flagged as actual bugs and still more
> are as yet uninspected.

most are mostly false. And the rest is getting looked at. What's the
problem?

> Adrian Bunk has his list of known regressions and, I'll bet, also some
> patches in the trivial queue for small issues.

and all this fixing is happening AS WELL as new features. What makes you
think suddenly even more fixing will happen?

> There are many parts of the kernel that are not documented.

this is where the OSDL Documentation Person will help a lot; a full time
person.



> I'm sure most distributions have a bunch of bug fixing patches lying
> about that they could push.

I doubt it; most have gotten real good at avoiding getting a huge patch
backlog since that is just incredibly expensive ;)

> - A while back, akpm made some statements about being worried that the
> 2.6 kernel is getting buggier
> (http://news.zdnet.com/2100-3513_22-6069363.html).

and at this years Kernel Summit actual data and general consensus showed
this was unfounded fear; the bugrates are more or less stable, but with
many more users.

> 
> - The need for the -stable tree and the (relatively large) number of
> -stable releases between each new major release clearly shows that we
> are leaving lots of regressions in our wake.

No it shows that bugs are getting fixed and delivered to you
IMMEDIATELY. Many many of the -stable things fixed are not in new
things. Is there anything in the -stable process that is not working for
you?




