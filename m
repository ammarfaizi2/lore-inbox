Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJNGSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTJNGSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:18:12 -0400
Received: from hockin.org ([66.35.79.110]:2569 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261898AbTJNGSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:18:07 -0400
Date: Mon, 13 Oct 2003 23:05:16 -0700
From: Tim Hockin <thockin@hockin.org>
To: retu <retu834@yahoo.com>
Cc: James Antill <james@and.org>, m.fioretti@inwind.it,
       linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
Message-ID: <20031014060516.GA19177@hockin.org>
References: <m31xtg3n3a.fsf@code.and.org> <20031014053155.31639.qmail@web13004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014053155.31639.qmail@web13004.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've managed to stay out of this so far, but I can't anymore.

On Mon, Oct 13, 2003 at 10:31:55PM -0700, retu wrote:
> NameYourClassLibrary_empty. Below a list pasted from
> the .net namespace with many dozens of classes
> covering everything from io to drawing. 

What is it about .net that gets your rocks off so well?  Let me try to make
this clear - W H Y.  Why?  Why do we need any of this crap?  why do you feel
that WE the kernel people should be the ones doing it?  Why are YOU not
doing it?  Why are you not funding someone who has a REAL clue to do it?
For enough money, I'll be happy to architect any piece of crap you want.
Maybe.

> They _appear for the most part to be consistent
> wrappers to underlying existing APIs (including some

What is wrong with existing APIs that they need wrapping?

> Hence, what would be needed is in the first place a
> component model (well architected - thin - efficient)

ok, I'll play along.  What components do you envision?  Files?  How about we
abstract that to a generic IO type.  Sockets?  How about we make them the
same as files at the lowest level, and if you want, you can get the higher
level IO type.  What else...Credentials?  How about a type for process IDs,
one for group IDs, and one for user IDs.

What do you want from us?

> efficiency reasons (Linux ought to scale to HPC

Are you implying it doesn't?  Because I know a lot of HPC sites that might
want to argue.  Ask SGI if linux scales for HPC.

> levels), broadening some application class library OR
> architecting something without the kernel in mind is

Right, because EVERYTHING belongs in the kernel.

> If there are multiple sets of classes for e.g. 2D
> drawing then so what as long as they use the same

oh, you mean drawing in an 80x25 console, or an SVGA high-res console?  Or
maybe you mean a serial port.  Or perhaps you mean X, or some other
windowing system.  How about we just integrate a GUI into the kernel, so
people don't have to have all those pesky choices.  To pick from the list
below:  Drawing, XML, Web have NOTHING to do with the kernel or it's
development.  I'd like to remind you that WE ARE NOT WINDOWS.  WE DO NOT
WANT TO BE WINDOWS.  This is the linux-kernel list.  You apparently do not
understand what we do here.

> Linux component model (which has yet to be defined or
> even a grain of consens found that it is necessary in
> the first place). 

You keep telling us it is needed.  We keep asking why.  You keep telling us
we need it.  We keep asking why. You keep...

> System 
> System.CodeDom 
> System.CodeDom.Compiler 
...
> System.Xml.XPath 
> System.Xml.Xsl 

Other than being named 'System', what do they have to do with the kernel?

> with a very decent component model and design
> philosphy on what to put in and what not it would
> enable people to quickly fill in the blanks (plus
> maybe some rapid abstracting/wrapping) which would do
> a very lot for the OS.  

Please, answer me this:  Who are you?  What is your background?  What do you
do?  How old are you?  Why do you keep bothering us?  Can you please just
put up or shut up already?


