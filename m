Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSJJWw4>; Thu, 10 Oct 2002 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJJWw4>; Thu, 10 Oct 2002 18:52:56 -0400
Received: from codepoet.org ([166.70.99.138]:39642 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262364AbSJJWwp>;
	Thu, 10 Oct 2002 18:52:45 -0400
Date: Thu, 10 Oct 2002 16:58:32 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Giuliano Pochini <pochini@shiny.it>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, Mark Mielke <mark@mark.mielke.cc>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010225832.GA26962@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Giuliano Pochini <pochini@shiny.it>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org, Mark Mielke <mark@mark.mielke.cc>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>
References: <1034221067.794.505.camel@phantasy> <XFMail.20021010153919.pochini@shiny.it> <20021010225050.GC2673@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010225050.GC2673@matchmail.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 10, 2002 at 03:50:50PM -0700, Mike Fedyk wrote:
> You are missing the point.  If the app thinks that might happen, it
> shouldn't use O_STREAMING.
> 
> Though, how do you get around some binary app using O_STREAMING when it
> shouldn't?

LD_PRELOAD to overload open(2) should do the job nicely

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
