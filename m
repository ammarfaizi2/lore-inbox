Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWDZUTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWDZUTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWDZUTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:19:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:684 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S964849AbWDZUTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:19:12 -0400
Date: Wed, 26 Apr 2006 21:19:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
       David Schwartz <davids@webmaster.com>
Subject: Re: C++ pushback
Message-ID: <20060426201909.GN27946@ftp.linux.org.uk>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:09:38PM -0700, Linus Torvalds wrote:
> The real problem with C++ for kernel modules is:
> 
>  - the language just sucks. Sorry, but it does.
>  - some of the C features we use may or may not be usable from C++ 
>    (statement expressions?)
>  - the compilers are slower, and less reliable. This is _less_ of an issue 
>    these days than it used to be (at least the reliability part), but it's 
>    still true.
>  - a lot of the C++ features just won't be supported sanely (ie the kernel 
>    infrastructure just doesn't do exceptions for C++, nor will it run any 
>    static constructors etc).

   - a lot of C++ advocates agree that some subset could be used sanely,
     but there's no agreement as to _which_ subset would that be.
