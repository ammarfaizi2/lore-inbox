Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbSJBSXR>; Wed, 2 Oct 2002 14:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262529AbSJBSXR>; Wed, 2 Oct 2002 14:23:17 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:29437 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262517AbSJBSXQ>; Wed, 2 Oct 2002 14:23:16 -0400
Date: Wed, 2 Oct 2002 11:21:14 -0700
From: Chris Wright <chris@wirex.com>
To: Robert Love <rml@tech9.net>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Capabilities-related change in 2.5.40
Message-ID: <20021002112114.A32178@figure1.int.wirex.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
References: <20021001164907.GA25307@nevyn.them.org> <20021001134552.A26557@figure1.int.wirex.com> <20021001211210.GA8784@nevyn.them.org> <20021002003817.B26557@figure1.int.wirex.com> <20021002132331.GA17376@nevyn.them.org> <1033569212.24108.20.camel@phantasy> <20021002094417.D26557@figure1.int.wirex.com> <1033582255.24476.52.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033582255.24476.52.camel@phantasy>; from rml@tech9.net on Wed, Oct 02, 2002 at 02:10:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Love (rml@tech9.net) wrote:
> On Wed, 2002-10-02 at 12:44, Chris Wright wrote:
> 
> > kernel/sched.c::static inline task_t *find_process_by_pid...
> > 
> > Guess that won't work w/out more changes.  Perhaps it's simpler/safer
> > to be just be explicit in this case.
> 
> >From 2.5.40:
> 
>         static inline task_t *find_process_by_pid(pid_t pid)
>         {
>         	return pid ? find_task_by_pid(pid) : current;
>         }
> 
> should work :)

heh, sorry, I meant the static inline part.
cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
