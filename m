Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTJ1M3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTJ1M3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:29:32 -0500
Received: from gprs196-218.eurotel.cz ([160.218.196.218]:34691 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263943AbTJ1M3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:29:31 -0500
Date: Tue, 28 Oct 2003 13:29:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Machek <pavel@suse.cz>, felipe_alfaro@linuxmail.org, mochel@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031028122907.GA1940@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <20031028224101.3220e0a6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028224101.3220e0a6.sfr@canb.auug.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Not sure... We do not want applications to know. Certainly we can't
> > send a signal; SIGPWR already has some meaning and it would be bad to
> > override it.
> 
> And SIGPWR is a bad choice anyway as the default action for SIGPWR
> is to terminate the process - I can't see people being amused if all
> their processes are killed when they suspend their laptop :-)
> 
> We could invent a new signal whose default action is ignore ... Solaris
> has SIGFREEZE and SIGTHAW (the comment in the header file says used by CPR
> - whatever that is).  SIGSUSPEND and SIGRESUME?

Is adding signal really that easy? I thought there's limited number of
them...

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
