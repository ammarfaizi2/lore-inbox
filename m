Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUFFFOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUFFFOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 01:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFFFOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 01:14:02 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:8400 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262882AbUFFFOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 01:14:00 -0400
Date: Sat, 5 Jun 2004 22:13:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-ID: <20040606051350.GA19485@taniwha.stupidest.org>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <20040605205547.GD20716@devserv.devel.redhat.com> <20040605215346.GB29525@taniwha.stupidest.org> <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C2A6E4.7020103@ThinRope.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 02:08:52PM +0900, Kalin KOZHUHAROV wrote:

> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097

is this repeartable?  if you strace -tt how often is this?

what's more, i wonder why this is going on?  i'd almost be tempted to
attach to it with gdb and take a bt from getpid and see wtf is going
on


  --cw
