Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274968AbTHGA1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274979AbTHGA1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:27:35 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:53168
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S274968AbTHGA1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:27:30 -0400
Message-ID: <1060216038.3f319ce652393@kolivas.org>
Date: Thu,  7 Aug 2003 10:27:18 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <3F31741F.30200@techsource.com> <200308070733.38135.kernel@kolivas.org> <3F319D0E.30307@techsource.com>
In-Reply-To: <3F319D0E.30307@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Timothy Miller <miller@techsource.com>:

> 
> 
> Con Kolivas wrote:
> >>For this, I reiterate my suggestion to intentionally over-shoot the
> >>mark.  If you do it right, a process will run an inappropriate length of
> >>time only every other time slice until the oscillation dies down.
> > 
> > 
> > Your thoughts are fine, and to some degree I do what you're proscribing,
> but I 
> > take into account the behaviour of real processes in the real world and
> their 
> > effect on scheduling fairness.
> 
> And I know you know a lot more about how real processes behave than I 
> do.  I'm not saying (or thinking) anything negative about you.  I'm just 
> trying to throw random thoughts into the mix just in case some small 
> part of what I say is useful inspiration for someone else such as yourself.
> 
> It is probably the case that the idea I suggest is BS and makes no real 
> difference or makes it worse anyhow.  :)

Nowhere do I recall saying your ideas were BS nor did I say you should stop 
throwing ideas at me. All thoughts are appreciated and considered. I'm pretty 
sure I said I do what you're suggesting anyway, bound by the limits of when 
those changes induce unfairness.

Con
