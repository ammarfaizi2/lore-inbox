Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTIZAQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 20:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTIZAQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 20:16:39 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:50048
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262076AbTIZAQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 20:16:38 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Keyboard oddness.
Date: Thu, 25 Sep 2003 18:59:55 -0500
User-Agent: KMail/1.5
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <200309221506.08331.rob@landley.net> <20030923000647.A1128@pclin040.win.tue.nl>
In-Reply-To: <20030923000647.A1128@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309251859.55887.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 17:06, Andries Brouwer wrote:

> > Any clues?  (This happens to me at least once an hour...)
>
> Some people have been reporting missing key releases (maybe also you),
> but these are all missing key presses. It is easiest to blame the
> keyboard, even though I could imagine ways to blame the kernel.

If the press is the first event, how does it know that it's missing?  Are you 
saying t got a key release that didn't match an active keypress?  This seems 
like a similar problem.  Are missing key releases flagged as errors and 
logged?  (Maybe the next time that key is pressed, if the system thinks it's 
already down?)

I'm certainly seeing missing releases.  Missing presses are just typos, I 
usually have enough gunk in the keyboard that it misses the occasional key 
anyway.  (This laptop lives in my backpack, with books and papers and Wendy's 
coupons and pens and...)  But "enter", "delete", or "cursor up" holding down 
for an extra second and change can be quite annoying.

> What about 2.4? Do you have to go back once an hour and add a symbol
> that was not transmitted correctly? Does 2.4 work perfectly for you?

Okay, over the past few days I've booted into 2.4.21 three times and done my 
standard text-intensive programming, email, and word processing.  I didn't 
notice any keys sticking.  (It's intermittent enough problem that this isn't 
difinitive, but it's the best I can do.)

On the other hand, the key repeat rate is a lot slower under 2.4.21, and I 
suspect it's using the hardware repeat instead of the software repeat.  The 
keyboard hardware definitely knows when a key gets released. :)

I.E. Under 2.4.21 I don't experience a problem.  (Maybe there is a technical 
problem with the hardware, but it doesn't manifest in a way that I ever 
notice.)  I'd be happy to live with the slower repeat rate if I could get 2.6 
to use 2.4's keyboard access method.

Rob
