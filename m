Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264578AbRFTT1l>; Wed, 20 Jun 2001 15:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264579AbRFTT1b>; Wed, 20 Jun 2001 15:27:31 -0400
Received: from srv01s4.cas.org ([134.243.50.9]:33279 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S264578AbRFTT1S>;
	Wed, 20 Jun 2001 15:27:18 -0400
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200106201927.PAA01484@mah21awu.cas.org>
Subject: Re: [OT] Threads, inelegance, and Java
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 20 Jun 2001 15:27:09 -0400 (EDT)
Cc: landley@webofficenow.com, linux-kernel@vger.kernel.org
In-Reply-To: <3B30DF30.9ED9889B@evision-ventures.com> from "Martin Dalecki" at Jun 20, 2001 07:36:48 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:> 
> Rob Landley wrote:
> 
> > Or if you like the idea of a JIT, think about transmeta writing a code
> > morphing layer that takes java bytecodes.  Ditch the VM and have the
> > processor do it in-cache.
> 
> Blah blah blah. The performance of the Transmeta CPU SUCKS ROCKS. No
> matter
> what they try to make you beleve. A venerable classical desing like
> the Geode outperforms them in any terms. There is simple significant
> information
> lost between compiled code and source code. Therefore no JIT compiler
> in this world will ever match the optimization opportunities of a
> classic
> C compiler! IBM researched opportunities for code morphing long ago
> before
> Transmeta come to live - they ditched it for good reasons. Well the
> actual
> paper states that the theorethical performance was "just" 20% worser
> then
> a comparable normal design. Well "just 20%" is a half universe diameter
> for
> CPU designers.

So what? Crusoe isn't designed for use in supercomputers. It's designed
for use in laptops where the user is running an email reader, a web
browser, a word processor, and where the user couldn't give a cr*p about
performance as long as it isn't noticeable (20% *isn't* for those types
of apps), but where the user does give a cr*p about how long his or her
battery lasts (ie, the entire business day, and not running out of power
at lunch time).

Yes, it *can* be used in a supercomputer (or more preferably, a cluster
of Linux machines), or even as a server where performance isn't the
number one concern and things like power usage (read: anywhere in
California right now ;-) ), and rack size are important. You can always
get faster, more efficient hardware, but you'll pay for it.

Remember, the whole concept of code-morphing is that the majority of
apps that people run repeat the same slice of code over and over (eg,
a word processor). Once crusoe has translated it once, it doesn't need
to do it again. It's the same concept as a JIT java compiler.

/Mike - who doesn't work for Transmeta, in case anyone was wondering... :-)
