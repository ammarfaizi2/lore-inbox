Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283733AbRK3RyB>; Fri, 30 Nov 2001 12:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283735AbRK3Rxw>; Fri, 30 Nov 2001 12:53:52 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:20230 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S283733AbRK3RxK>; Fri, 30 Nov 2001 12:53:10 -0500
Subject: Re: Coding style - a non-issue
From: Henning Schmiedehausen <hps@intermeta.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011130092730.Q14710@work.bitmover.com>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
	<Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu>
	<20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de>
	<20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge>
	<3C07B820.4108246F@mandrakesoft.com> <1007140529.6655.37.camel@forge> 
	<20011130092730.Q14710@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 18:53:05 +0100
Message-Id: <1007142785.6655.39.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-30 at 18:27, Larry McVoy wrote:

Larry

> I think that if you ask around, you'll find that the pros use a coding 
> style that isn't theirs, even when writing new code.  They have evolved
> to use the prevailing style in their environment.  I know that's true for
> me, my original style was 4 space tabs, curly braces on their own line,
> etc.  I now code the way Bill Joy codes, fondly known as Bill Joy normal
> form.

I don't have to ask around. You may want to know that I work in this
industry for about 15 years and write commercial code (that is "code
that ships") since about that time (and I don't run around telling
everybody each and every time about it and what I've already done). I've
written code in a good two dozen languages (including things that really
deserve to die like Comal) and I've worked in projects from "one man
show" to "lots of people in Elbonia also work on this". So, please,
please, Larry, _STOP THE FUCK PATRONIZING OTHERS_. Actually, I try to
consider myself a "pro" in some languages and a bloody amateur in others
(like Lisp or Python). That is "pro" as in "pays his bills with writing
software".

> 
> Anyway, if you think any coding style is better than another, you completely
> miss the point.  The existing style, whatever it is, is the style you use.
> I personally despise the GNU coding style but when I make changes there,
> that's what I use because it is their source base, not mine.

We're in violent agreement here. Unfortunatly we do not agree whether it
is good to force a driver writer (which is, IMHO, most of the time a
well defined entity of one, maybe two or three source code files that
uses a well established (though sometimes changing) API to talk to the
kernel) to convert his style to the linux kernel ("our style is better
than yours, you must convert") or allow him to continue working (and
maintaining) his driver in the kernel tree in his own style. Even if his
variable names contain Uppercase letters.

The question now is, what is "amateur behaviour": Forcing this driver
writer to change or to tolerate his style in his driver? We're still
talking about a driver, not about the VM subsystem or the networking
core.

And will "putting up a list of the ten most ugly drivers with author
names" really persuade this author to change? Or simply to drop out and
write a driver for an OS that may be more tolerant?

That the core components of a large software project must adhere to a
style guide (and the Linux style guide is pretty good, because it is
_SHORT_), there is no disagreement between you and me.

	Regards
		Henning


 
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

