Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269466AbRHGVfU>; Tue, 7 Aug 2001 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269467AbRHGVfK>; Tue, 7 Aug 2001 17:35:10 -0400
Received: from cardinal0.Stanford.EDU ([171.64.15.238]:25774 "EHLO
	cardinal0.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S269466AbRHGVet>; Tue, 7 Aug 2001 17:34:49 -0400
Date: Tue, 7 Aug 2001 14:34:48 -0700 (PDT)
From: Ted Unangst <tedu@stanford.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: summary Re: encrypted swap
In-Reply-To: <fa.g4fleqv.1mle133@ifi.uio.no>
Message-ID: <Pine.GSO.4.31.0108071419300.2838-100000@cardinal0.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

basically, there are a few scenarios that have come up.

1. notebook is stolen.  presumably, if you have sensitive data, you would
know not to suspend and only power down completely after use.  so the
notebook can be stolen while the power is on, or while the power is off.
if the power is off, all is good, the data is safe.  if the power is on, i
don't think this was a random street thug who snatched your notebook.
(what were you doing working on sensitive data in a dark alley?)
presumably, you were there with it.  in that case, it was probably a
"directed" hit by someone after the data, and not just the notebook.
there's a good chance that *you* will also be taken if they want the data
that bad.  really, who leaves their notebook on and unattended?  esp. if
it contains super sensitive data.  and whether you know the swap passwork
or not, you will know the password for your email, and you're in for a
long night with some truth serum and a meat hook.  ;)

2. a server, or maybe a workstation.  if you are working with sensitive
data, but wouldn't notice the "plumber" sawing apart your computer to
extract ram chips, you're in bad shape.  a quick hit and run operation
wouldn't have time for all the fancy hacks and cpu swaps to get at the
swap password.  and again, there are *people* who know everything on that
disk.  and they will probably be eaiser to brute force than the hard
drive.

conclusion:  if your data is that valuable, you will need a small army to
protect it.  don't bother encrypting swap, because guns are a better means
of protection.  if your data is only semi-valuable, or private that you
wouldn't want random others to read it, then swap encryption is good.
it's a nice feature that some people might like to have.  does it solve
every problem? no.  but the people in the edge cases are most likely very
aware of the possibilities.

btw, i've used it, just for fun, and didn't notice too much performance
hit.

implementation paper:
http://www.openbsd.org/papers/swapencrypt.ps

ted




--
"I read a funny story about how the Republicans freed the slaves.
The Republicans are the ones who created slavery by law in the
1600's.  Abraham Lincoln freed the slaves and he was not a
Republican."
      - M. Barry, Mayor of Washington, DC

