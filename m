Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTINKzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 06:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTINKzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 06:55:17 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:48861
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262363AbTINKzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 06:55:12 -0400
Date: Sun, 14 Sep 2003 06:55:09 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: ebiederm@xmission.com, davids@webmaster.com, der.eremit@email.de,
       linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
Message-Id: <20030914065509.33e31035.seanlkml@rogers.com>
In-Reply-To: <Pine.LNX.4.10.10309131030590.16744-100000@master.linux-ide.org>
References: <m14qzjmp0d.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.10.10309131030590.16744-100000@master.linux-ide.org>
Organization: 
X-Mailer: Sylpheed version 0.9.4-gtk2-20030802 (GTK+ 2.2.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.103.233.222] using ID <seanlkml@rogers.com> at Sun, 14 Sep 2003 06:54:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003 10:34:12 -0700 (PDT)
Andre Hedrick <andre@linux-ide.org> wrote:
> 
> On 11 Sep 2003, Eric W. Biederman wrote:
> 
> > "David Schwartz" <davids@webmaster.com> writes:
> > 
> > > 	The GPL_ONLY stuff is an attempt to restrict use. There is nothing
> > > inherently wrong with attempts to restrict use. One could argue that the
> > > root permission check on 'umount' is a restriction on use. Surely the GPL
> > > doesn't mean you can't have any usage restrictions at all.
> > 
> > No the GPL_ONLY stuff is an attempt to document that there is no conceivable
> > way that using a given symbol does not create a derived work.  
> 
> Bzzit ... GPL_ONLY stuff is an attempt to retrict usage by removing access
> to the unprotectable API.  And for anyone claiming there is not API to
> protect, the kernel source is the manual to the API.  The foolish intent
> and design to hide the API has caused the kernel itself to become the
> manual.
> 
> This is even obvious to people, like myself, who are not lawyers.

Andre,

You seem to be mixing two forms of "use"; the right to use GPL'd source
and the right to use an operational Linux kernel.    

You are free to take the source and do whatever you want with it, restricted
only by the terms of the GPL.  Other people have the right to do the same.
There is nothing in the GPL that says how a program must behave when 
_executing_.  Therefore, if you don't like how the resulting executable 
operates, _tough_.   Your option, and the _freedom_ provided by the GPL, 
is to fork the source. 

No different than a kernel provided by the Church of Holy Computation 
which refuses to operate on Sunday.   You may disagree with the 
restriction, but surely they are free to add such a restriction to their
kernel source.

As it stands, you are complaining about a _runtime_ restriction;  ignoring 
your ability to change the source.   By insisting that other people remove 
checks for license type, you are trying to restrict  what others do with 
_their_ source.  By design, the kernel is already full of runtime restrictions. 
There is nothing special about a runtime limitation imposed on modules 
lacking the GPL symbol.   Just to drive the point home,  please consider that there is nothing wrong with a kernel that refuses 
to load modules that _DO_ contain the GPL symbol.

In short, fork off...
Sean

