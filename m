Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSCPAkL>; Fri, 15 Mar 2002 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293615AbSCPAjy>; Fri, 15 Mar 2002 19:39:54 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:47632 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293603AbSCPAjj>;
	Fri, 15 Mar 2002 19:39:39 -0500
Date: Fri, 15 Mar 2002 17:40:36 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
Message-ID: <20020315174036.A5068@hq.fsmlabs.com>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <1016157250.4599.62.camel@phantasy> <3C91B2A1.48C74B82@ianduggan.net> <1016202310.908.1.camel@phantasy> <15506.7486.729120.64389@kim.it.uu.se> <1016219530.904.21.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1016219530.904.21.camel@phantasy>; from rml@tech9.net on Fri, Mar 15, 2002 at 02:11:49PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 02:11:49PM -0500, Robert Love wrote:
> If you "poke the processor", to be SMP-safe, you should hold a lock to
> prevent multiple concurrent "pokings of the processor" - thus you become
> preempt-safe.

Without preempt:
	x = movefrom processor register;
        do_something with x

is safe in SMP
With SMP it requires a lock.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

