Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWFUPxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWFUPxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWFUPxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:53:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:8601 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751174AbWFUPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:53:32 -0400
Date: Wed, 21 Jun 2006 11:53:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ryan McAvoy <ryan.sed@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
In-Reply-To: <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0606211152060.30583@gandalf.stny.rr.com>
References: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com> 
 <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com>
 <642640090606210804k282085efm84476af3a8fa08b1@mail.gmail.com>
 <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2006, Steven Rostedt wrote:

>
> >
> > I decided to review the changes I made in getting it to compile and
> > was hoping that this one may be the cause of the instability.  I
> > thought that perhaps this change was incorrect because
> > include/asm-mips/rwsem.h is introduced by the rt-preempt patch and
>
> Ha, you're right!  (added John Cooper to this so he can clean up this mess
> ;)
>

Forget John, I guess he's no longer at TimeSys.  Just got a bounce from
his email address.

-- Steve
