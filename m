Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSLVBM0>; Sat, 21 Dec 2002 20:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSLVBM0>; Sat, 21 Dec 2002 20:12:26 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:60574
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S264646AbSLVBMZ> convert rfc822-to-8bit; Sat, 21 Dec 2002 20:12:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel GCC Optimizations
Date: Sat, 21 Dec 2002 19:20:28 -0600
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.33.0212212307460.24398-100000@muur.intranet.vanheusden.com>
In-Reply-To: <Pine.LNX.4.33.0212212307460.24398-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212211920.28985.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 December 2002 04:10 pm, folkert@vanheusden.com wrote:
> > > Is there any risk using -O3 instead of -O2 to compile the
> > > kernel, and why?
> >
> > * It might uncover subtle bugs that would otherwise not occur.
>
> I wonder: for the sake of performance and good use of the precious
> clock- cycles, shouldn't there be made a start of fixing those
> bugs? Assuming that the bugs you're talking about are not
> compiler-bugs, they *are* bugs in the code that should be fixed,
> shouldn't they?
>
> > * Compiling with unusual options means that less people will know
> > about any problems it causes you.
>
> So, let's make it -O6 per default for 2.7.x/3.1.x?

Let's not. I'd rather have the best kernel developers concentrating on 
finishing important kernel features rather than digging their way out 
of esoteric optimizer debugging sessions only to find it was a flaw 
in gcc. The difference in performance boost between -O2 and greater 
levels isn't usually enough to make a significant impact, not as 
significant as the introduction of important new features, for 
example.
---scott
