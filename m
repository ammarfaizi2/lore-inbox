Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263951AbUDFSsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbUDFSsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:48:19 -0400
Received: from web40502.mail.yahoo.com ([66.218.78.119]:10173 "HELO
	web40502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263951AbUDFSsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:48:06 -0400
Message-ID: <20040406184803.51677.qmail@web40502.mail.yahoo.com>
Date: Tue, 6 Apr 2004 11:48:03 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: John Stoffel <stoffel@lucent.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16498.63185.267645.387612@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- John Stoffel <stoffel@lucent.com> wrote:
> >>>>> "Sergiy" == Sergiy Lozovsky
> <serge_lozovsky@yahoo.com> writes:
> 
> >> Policy has no place inside the kernel.
> 
> Sergiy> Root privileges (ability to send a signal to
> any process,
> Sergiy> access any file and so on) are encoded in
> the kernel.
> 
> But that does not require a LISP interpreter in the
> kernel either.
> And you are also mistaking policy with a capability.
>  Who has root is
> a policy, what root can do is a capability.  They
> are seperate issues.

UID is stored in a task structure in the kernel as
well as what to do with it. With VXE both policy and
capability are in a file (out of the kernel), though
there is an option to preload it into the kernel
before execution of particular system starts.

> Sergiy> So all interaction with the kernel goes via
> VM.  Investing
> Sergiy> some time into carefull parameter check in
> VM allows to avoid
> Sergiy> the same work for each new application.
> 
> You have not given us a simple example of how this
> VM would be used in
> the kernel and what it provides.  I think that would
> help people
> understand why you think this is so needed.

I though I did. Here is a link to the site with
detailed description of the system. It works since
1999. - http://vxe.quercitron.com

It's not an example - it's working system.

There was an article in LinuxFocus - it's less
technical and more compact -
http://jamesthornton.com/linux/LinuxFocus/English/January2000/article133.shtml

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
