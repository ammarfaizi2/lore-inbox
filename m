Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTEFWfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbTEFWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:35:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12672 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262021AbTEFWfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:35:53 -0400
Date: Tue, 6 May 2003 23:48:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506224824.GE6284@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <20030506204305.GA5546@elf.ucw.cz> <20030506221819.GC6284@mail.jlokier.co.uk> <1052256672.1983.174.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052256672.1983.174.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-05-06 at 23:18, Jamie Lokier wrote:
> > If I load a Java class into a Java VM, that class is executing in the
> > VM's "userspace", even though both the class and VM execute together
> > in the underlying kernel's userspace.  If I load an Emacs Lisp library
> > into Emacs, that's ok too in the same way.
> 
> Thats not actually clear either. The kernel contains the clear syscall
> message for good reasons. The GPL itself talks about stuff that comes
> normally with the OS very carefully for similar reasons.

I'd get to define "the OS" so that is not a problem :) You could
expect an equivalent "clear syscall message", although that is more
problematic to define in an environment where there is no static code
being executed.

> You see there isn't any difference between an interpreter hitting
> 	Java bytecode 145
> and a function call of 
> 	perform_java_bytecode(145);
> 
> Indeed the JVM may turn one into the other.

There are a few GPL'd Java programs around (I've written a couple
myself), and no complaints about the above transformation so far.

> If you think that is bad remember that the DMCA and other rulings have
> held shrink wrap licenses can sometimes overrule US style "fair use", so
> your JVM in JITting code may be making you liable for a license
> violation for some applications.

I was going to write:

   I think you've made a big jump in logic there.  I sympathise, as I too
   might have to quit computing if European law follows the US, but I
   don't agree with the big leap you just made.

But then (<shudder>) I realised you are right.  The kind of kernel
which I'm envisioning would be capable of cracking open some kinds of
protected application automatically, as a mere side effect.  (It has
powerful DWIM semantics :) And that would make _something_ illegal to
write - I'm not sure what, though.

-- Jamie
