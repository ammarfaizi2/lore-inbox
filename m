Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267318AbSLRSzb>; Wed, 18 Dec 2002 13:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSLRSza>; Wed, 18 Dec 2002 13:55:30 -0500
Received: from auto-matic.ca ([216.209.85.42]:29200 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267318AbSLRSz3>;
	Wed, 18 Dec 2002 13:55:29 -0500
Date: Wed, 18 Dec 2002 14:12:07 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218191207.GA21147@mark.mielke.cc>
References: <sneakums@zork.net> <6u4r9bsakz.fsf@zork.zork.net> <200212181410.gBIEAod6027746@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212181410.gBIEAod6027746@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 11:10:50AM -0300, Horst von Brand wrote:
> Sean Neakums <sneakums@zork.net> said:
> > How are system calls a new feature?  Or is optimizing an existing
> > feature not allowed by your definition of "feature freeze"?
> This "optimizing" is very much userspace-visible, and a radical change in
> an interface this fundamental counts as a new feature in my book.

Since operating systems like WIN32 are at least published to take
advantage of SYSENTER, it may not be in Linux's interest to
purposefully use a slower interface until 2.8 (how long will that be
until people can use?). The last thing I want to read about in a
technical journal is how WIN32 has lower system call overhead than
Linux on IA-32 architectures. That might just be selfish of me for
the Linux community... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

