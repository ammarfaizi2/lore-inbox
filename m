Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRDBMrX>; Mon, 2 Apr 2001 08:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRDBMrN>; Mon, 2 Apr 2001 08:47:13 -0400
Received: from assembly.state.ny.us ([204.97.104.2]:34488 "EHLO
	assembly.state.ny.us") by vger.kernel.org with ESMTP
	id <S129051AbRDBMrI>; Mon, 2 Apr 2001 08:47:08 -0400
Date: Mon, 2 Apr 2001 08:46:07 -0400
From: jerry <jdinardo@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: tcgetattr fails in 2.4.3
Message-ID: <20010402084607.A75@ix.netcom.com>
In-Reply-To: <20010331191253.A84@ix.netcom.com> <20010402102357.A16785@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010402102357.A16785@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Mon, Apr 02, 2001 at 10:23:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I am running pppd 2.4.0b4 so that should not be the problem. However if the
 problem is related to tcgetattr bogus failure, then I do not think
 pppd would be the problem especially since it is failing in chat.
 
 Does anyone know under what conditions a errno=5 (IO error) should be
 returned from tcgetattr(fd,&t) when fd is opened (rw).

> jerry wrote:
> > ppp chat script stopped working under 2.4.3. I ran a program of my own
> > that opens ttyS1 and it also fails on a tcgetattr with errno=5 (IO error).
> > The ppp chat script and my program both work fine under 2.4.2 and older.
> 
> I noticed that, but then I noticed I'm using pppd 2.3.11, and
> Documentation/Changes says I should use 2.4.0b1.  Then again
> Documentation/Changes said the same thing in kernel 2.4.2 as well, and
> pppd 2.3.11 works fine there.
> 
> -- Jamie
> 
