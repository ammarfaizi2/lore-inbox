Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWEPUD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWEPUD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWEPUD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:03:27 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:37644 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750839AbWEPUD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:03:27 -0400
Date: Tue, 16 May 2006 22:03:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
Message-ID: <20060516200313.GO11191@w.ods.org>
References: <4469D296.8060908@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469D296.8060908@perkel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 06:24:38AM -0700, Marc Perkel wrote:
> As most of you know the United States is tapping you telephone calls and 
> tracking every call you make. The next logical step is to start tapping 
> your computer implanting spyware into operating systems. Since Windows 
> and OS-X are proprietary this can be done more easilly with the 
> cooperation of Microsoft and Apple.
> 
> So what about Linux? With thousands of people working on the Kernel if 
> someone from the NSA wanted to slip a back door into the Kernel, could 
> the do that? I know it's open source and it could be found if anyone 
> looks but is anyone looking? Is this something that would get noticed if 
> someone tried to do it? I'd like to think it would, but I'm going to ask 
> anyway just to make sure.
> 
> Conversely, if Microsoft or Apple cooperated with the US government 
> could they implant sptware without packets or hidden files being noticed?
> 
> I'm in the process of writing some articles about it and want to raise 
> the issue of US government implanted spyware everywhere. I know some 
> people might think this a little off topic but I'd rather be safe than 
> sorry. Who better to ask this question of than those who develop the 
> kernel?
> 
> Thanks in advance.

There is no warranty that this cannot happen. Indeed, it has already
happened and will probably do again. A backdoor was found in some code
introduced in the bitkeeper repository, but it was noticed almost
immediately. Nobody has a full knowledge on the kernel today, but there
are *many* people with complementary knowledge, with experts in every
area. All code gets reviewed by hundreds of eyeballs all the time, and
such events might happen from time to time, with fixes proposed by other
people as soon as they get discovered as simple bugs or vulnerabilities.

The only way for such attacks to be effective would be to introduce
thousands of them, in the hope that one of them would not get noticed.
But do you think that kernel gods would accept to be fed patches very
long if this happened ? I don't think so. There already are discussions
about a cleanup step on current code while no backdoor seems to be in
the air.

In the hope that I have reassure you,
Willy

