Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264017AbUDFVR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264003AbUDFVR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:17:27 -0400
Received: from web40514.mail.yahoo.com ([66.218.78.131]:23556 "HELO
	web40514.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264017AbUDFVP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:15:56 -0400
Message-ID: <20040406211550.30263.qmail@web40514.mail.yahoo.com>
Date: Tue, 6 Apr 2004 14:15:50 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: root@chaos.analogic.com
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0404061437020.8186@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Tue, 6 Apr 2004, Sergiy Lozovsky wrote:
> 
> Let me get this right. You learned LISP right?

25 years ago.

> Now you think it's the only way to go. There is
> a name for this, where one starts to identify
> with his captors... It's called the Stockholm
> Syndrome, named after four Swedes bound in bank-
> vault for six days became attached to their captors.

Last time I used LISP (except of the project we
discuss) was 18 years ago (on IBM mainframes). So your
conclusion doesn't sound right :-)

I never used any LISP on PC prior to VXE project.

> LISP is just a TOOL and a poor one, at that. There
> are many tools available under Unix/Linux and, if
> you don't like what's available, you can readily
> make your own. Once you learn new tools, the
> Stockholm
> Syndrome will go away although you'll probably
> always
> like the first tool you learned to use. I like DDT,
> myself.
> 
> Nobody who has a clue would suggest LISP inside a
> kernel.
> When I first read this, I was sure it was an
> April-fool
> joke, although somewhat cruel, kinda like; "what to
> do
> with a dead cat..."

So, you still didn't say a word why it was a bad
choice. Can you share your thought on that?

I didn't just pick up LISP - I EXPLAINED my reasons.
if you missed my explanation here is a short summary.

1. I needed solution to implement some procedural
functionality within the kernel. This functionality
should be expressed with some high level language
(shorter development time and more compact source
code). This functionality should be
loadable/unloadable to the kernel.

2. Size of the interpreter should be minimal.

3. Kind of real time - no ordinary garbage collector.
And automatic memory management at the same time.

4. Easiest syntax possible - so interpreter would be
compact. Simpler - the better :-) I don't like
complicated things :-)

5. Well known. So there would be people around who
already know this language and expectations are clear.
And there are books around about this language.

6. Ability to handle/represent complex data
structures.

7. Errors/bugs in loadable functions should not cause
trouble for other tasks and kernel itself. (To the
extent possible for sure).

8. It should be universal (general purpose) language
which gives ability to make any manipulations with
numbers, strings, bits and data structures. So I would
be sure that functionality I want to express is not
limited by the language.

That's why particular LISP interpreter was chosen.
It's wrong to say that just language was chosen. I
would never start work of fitting Common Lisp into the
kernel. Particular general purpose language
interpreter was chosen.

Serge.

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine
> (797.90 BogoMips).
>             Note 96.31% of all statistics are
> fiction.
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
