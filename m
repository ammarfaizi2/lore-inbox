Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279939AbRKBCRA>; Thu, 1 Nov 2001 21:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279940AbRKBCQt>; Thu, 1 Nov 2001 21:16:49 -0500
Received: from [202.135.142.194] ([202.135.142.194]:786 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S279939AbRKBCQk>; Thu, 1 Nov 2001 21:16:40 -0500
Date: Fri, 2 Nov 2001 13:20:14 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-Id: <20011102132014.41f2d90a.rusty@rustcorp.com.au>
In-Reply-To: <15zGYm-1gibkeC@fmrl05.sul.t-online.com>
In-Reply-To: <E15zF9H-0000NL-00@wagner>
	<15zGYm-1gibkeC@fmrl05.sul.t-online.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001 13:06:00 +0100
Tim Jansen <tim@tjansen.de> wrote:

> On Thursday 01 November 2001 11:32, Rusty Russell wrote:
> > I believe that rewriting /proc (and /proc/sys should simply die) is a
> > better solution than extending the interface, or avoiding it
> > altogether by using a new filesystem.
> 
> I am currently working on something like this, too. It's using Patrick 
> Mochel's driverfs patch 
> (http://www.kernel.org/pub/linux/kernel/people/mochel/device/driverfs.diff-1030) 
> as a base and adds the functionality of the extensions that I did to proc fs 
> for my device registry patch 
> (http://www.tjansen.de/devreg/proc_ov-2.4.7.diff).

Hi Tim!

	Firstly: obviously, I think that work on /proc is a worthy and excellent
thing to be doing: everyone has been complaining about it since its introduction
(for good reason).

	I'm not sure about such explicit typing: see my patch (the existing types are
only for convenience: you can trivially supply your own).  I agree with the
"one file, one value" idea.  I also went for dynamic directories for those who
don't want to continually register/deregister.

I suggest you read my patch 8)
Rusty.
