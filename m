Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTJNGBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTJNGBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:01:21 -0400
Received: from dyn-ctb-210-9-245-201.webone.com.au ([210.9.245.201]:50183 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261868AbTJNGBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:01:19 -0400
Message-ID: <3F8B9114.9030502@cyberone.com.au>
Date: Tue, 14 Oct 2003 16:00:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: retu <retu834@yahoo.com>
CC: James Antill <james@and.org>, m.fioretti@inwind.it,
       linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
References: <20031014050136.80712.qmail@web13007.mail.yahoo.com>
In-Reply-To: <20031014050136.80712.qmail@web13007.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



retu wrote:

>// these ungeneric interfaces will kill. Right now
>it's a
>{/usr/local/,/usr/bin/,/usr/..}NameYourClassLibrary_empty.
>Below a list pasted from the .net namespace with many
>dozens of classes covering everything from io to
>drawing. 
>
>They _appear for the most part to be consistent
>wrappers to underlying existing APIs (including some
>for >kernelspace< to userspace), are quite well done
>although a little on the heavy side. I've not seen
>Nextstep for years but this was a very good design
>along the same lines and much thinner (implemented to
>fly on 20MHz+ 68040s).
>
>Hence, what would be needed is in the first place a
>component model (well architected - thin - efficient)
>that would allow folks to populate the other areas
>successively. Replicating .net for licensing and
>efficiency reasons (Linux ought to scale to HPC
>levels), broadening some application class library OR
>architecting something without the kernel in mind is
>not it I believe. It's gotta come from the core, have
>the ingenuity that leads others to build on it and not
>start with a disconnect (to the kernelspace that is). 
>
>If there are multiple sets of classes for e.g. 2D
>drawing then so what as long as they use the same
>Linux component model (which has yet to be defined or
>even a grain of consens found that it is necessary in
>the first place). 
> 
>Now here's the competition:
>

Retu,
I don't mean to sound rude, but you're mail is somewhat incoherent. 
Also, you
have not addressed some people's questions. This really frustrates 
people and
that can cause a potentially useful discussion to go nowhere.

What you need to do is raise or elaborate on _one_ idea per paragraph, have
some sort of introduction or overview and logically structure your argument
from there, stop using parentheses, stop using marketing buzzwords and most
of all, explain specifically WHY your ideas are better than what is already
available in Linux. Don't keep repeating how other operating systems do 
things
unless you back it up with an analysis of WHY it is better than what Linux
has.

Best Regards,
Nick Piggin


