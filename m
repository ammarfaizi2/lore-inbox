Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWDZVhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWDZVhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWDZVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:37:11 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43531 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964888AbWDZVhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:37:10 -0400
Date: Wed, 26 Apr 2006 23:37:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: C++ pushback
Message-ID: <20060426213700.GB22894@mars.ravnborg.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <20060426201909.GN27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426201909.GN27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 09:19:09PM +0100, Al Viro wrote:
> On Wed, Apr 26, 2006 at 01:09:38PM -0700, Linus Torvalds wrote:
> > The real problem with C++ for kernel modules is:
> > 
> >  - the language just sucks. Sorry, but it does.
> >  - some of the C features we use may or may not be usable from C++ 
> >    (statement expressions?)
> >  - the compilers are slower, and less reliable. This is _less_ of an issue 
> >    these days than it used to be (at least the reliability part), but it's 
> >    still true.
> >  - a lot of the C++ features just won't be supported sanely (ie the kernel 
> >    infrastructure just doesn't do exceptions for C++, nor will it run any 
> >    static constructors etc).
> 
>    - a lot of C++ advocates agree that some subset could be used sanely,
>      but there's no agreement as to _which_ subset would that be.
The original question was related to port existing C++ code to be used
as a kernel module.
Magically this always ends up in long discussions about how applicable
C++ is the the kernel as such which was not the original intent.

So following the original intent it does not matter what subset is
sanely used, only what adaptions is needed to kernel proper to support
modules written in C++.

But I have seen no patches this time either, so required modifications
are yet to be identified.

	Sam
