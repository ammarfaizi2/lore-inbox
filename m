Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283712AbRK3RQB>; Fri, 30 Nov 2001 12:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283713AbRK3RPv>; Fri, 30 Nov 2001 12:15:51 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:43538 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S283712AbRK3RPe>; Fri, 30 Nov 2001 12:15:34 -0500
Subject: Re: Coding style - a non-issue
From: Henning Schmiedehausen <hps@intermeta.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C07B820.4108246F@mandrakesoft.com>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
	<Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu>
	<20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de>
	<20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> 
	<3C07B820.4108246F@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 18:15:28 +0100
Message-Id: <1007140529.6655.37.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-30 at 17:47, Jeff Garzik wrote:

Hi,

> The security community has shown us time and again that public shaming
> is often the only way to motivate vendors into fixing security
> problems.  Yes, even BSD security guys do this :)
> 
> A "Top 10 ugliest Linux kernel drivers" list would probably provide
> similar motivation.

A security issue is an universal accepted problem that most of the time
has a reason and a solution.

Coding style, however, is a very personal thing that start with "shall
we use TABs or not? (Jakarta: No. Linux: Yes ...) and goes on to "Is a
preprocessor macro a good thing or not" until variable names (Al Viro:
Names with more than five letters suck. :-) Java: Non-selfdescriptive
names suck. Microsoft: Non-hungarian names suck) and so on.

And you really want to judge code just because someone likes to wrap
code in preprocessor macros or use UPPERCASE variable names? 

Come on. That's a _fundamental_ different issue than dipping vendors in
their own shit if they messed up and their box/program has a security
issue. Code that you consider ugly as hell may be seen as "easily
understandable and maintainable" by the author. If it works and has no
bugs, so what? Just because it is hard for you and me to understand (cf.
"mindboggling unwind routines in the NTFS" (I thing Jeff Merkey stated
it like this). It still seems to work quite well.

Are you willing to judge "ugliness" of kernel drivers? What is ugly? Are
Donald Beckers' drivers ugly just because they use (at least on 2.2)
their own pci helper library? Is the aic7xxx driver ugly because it
needs libdb ? Or is ugly defined as "Larry and Al don't like them"? :-)

Flaming about coding style is about as pointless as flaming someone
because he supports another sports team. There is no universal accepted
coding style. Not even in C.

	Regards
		Henning

 
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

