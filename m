Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTLLIHO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 03:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTLLIHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 03:07:14 -0500
Received: from findaloan.ca ([66.11.177.6]:17599 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S264509AbTLLIHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 03:07:10 -0500
Date: Thu, 11 Dec 2003 11:33:50 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031211163350.GC29601@mark.mielke.cc>
References: <3FD78645.9090300@wmich.edu> <Pine.LNX.4.44.0312110046350.3331-100000@gaia.cela.pl> <20031211015348.GA23489@mark.mielke.cc> <yw1xoeufhhjm.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xoeufhhjm.fsf@kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:42:21AM +0100, Måns Rullgård wrote:
> Mark Mielke <mark@mark.mielke.cc> writes:
> > I was under the impression, that on the x86 processors, it is not
> > possible to have more than ~640Kb of 'unswappable'
> > memory. Everything else *is* swappable.
> Swappable or not doesn't depend on physical memory address.  It
> depends on whether the kernel memory management allows it or not.  No
> Linux kernels to date will swap out kernel memory.  The swappability
> of a page is determined by some flags when it is allocated.

Is this something that should be fixed? Or is this a related issue where
the perceived gain is small enough that it isn't worth tackling, or modules
is the recommended and desirable solution to this problem?

Is Microsoft Windows different in this regard?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

