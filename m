Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSGKXyw>; Thu, 11 Jul 2002 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317871AbSGKXyv>; Thu, 11 Jul 2002 19:54:51 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:57326 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S314078AbSGKXyv>; Thu, 11 Jul 2002 19:54:51 -0400
Date: Thu, 11 Jul 2002 16:56:36 -0700
From: Chris Wright <chris@wirex.com>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: jail() system call (was Re: prevent breaking a chroot() jail?)
Message-ID: <20020711165636.B21285@figure1.int.wirex.com>
Mail-Followup-To: Shaya Potter <spotter@cs.columbia.edu>,
	linux-kernel@vger.kernel.org
References: <200207051516.g65FGYY20854@marc2.theaimsgroup.com> <20020705161750.GO1548@niksula.cs.hut.fi> <1026428914.8085.11.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1026428914.8085.11.camel@zaphod>; from spotter@cs.columbia.edu on Thu, Jul 11, 2002 at 07:08:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shaya Potter (spotter@cs.columbia.edu) wrote:
> Wow, this is what I need.  Would there be any interest in having this
> syscall in Linux, as I need to design something like this anyways for
> the research we are doing.
> 
> A first stab implementation would probably be as a module (as our
> research is based on a being usable just as a loadable module, w/o any
> direct kernel patch need, therefore until something is accepted into the
> kernel, we would need it like this), but we'd prefer it, and it
> definitely would be cleaner to have the jail tests integrated into the
> syscall and not wrapped by the module.

You could implement this policy in a security module.
http://lsm.immunix.org.

I don't believe you can do all of jail() with just capabilities, and as
a module it can always be extended.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
