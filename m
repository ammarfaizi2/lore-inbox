Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbTGLT6m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbTGLT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:58:42 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:45752 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268396AbTGLT6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:58:40 -0400
Date: Sat, 12 Jul 2003 22:12:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
Subject: Re: [ACPI-sppt] Re: [2.5.75] S3 and S4
Message-ID: <20030712201256.GA446@elf.ucw.cz>
References: <20030711193611.GA824@dreamland.darkstar.lan> <20030711200053.GA402@elf.ucw.cz> <20030712164542.GA1157@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712164542.GA1157@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Unable to handle kernel paging request at virtual address 40107114
> > >  printing eip:
> > > 40107114
> > > *pde = 2dbf6067
> > > *pte = 00000000
> > > Oops: 0004 [#1]
> > > CPU:    0
> > > EIP:    0073:[<40107114>]    Not tainted
> > > EFLAGS: 00010202
> > > EIP is at 0x40107114
> > > eax: ffffffea   ebx: 00000001   ecx: 080d440c   edx: 00000002
> > > esi: 00000002   edi: 080d440c   ebp: bffffae8   esp: bffffab8
> > > ds: 007b   es: 007b   ss: 007b
> > > Process bash (pid: 484, threadinfo=ed776000 task=ef1e40c0)
> > >  <6>note: bash[484] exited with preempt_count 1
> > > pdflush left refrigerator
> > > e100: eth0 NIC Link is Up 10 Mbps Half duplex
> > > 
> > > ksymoops says:
> > > 
> > > Warning (Oops_read): Code line not seen, dumping what data is available
> > > 
> > > 
> > > >>EIP; 40107114 Before first symbol   <=====
> > > 
> > > >>eax; ffffffea <__kernel_rt_sigreturn+1baa/????>
> > 
> > That's bad. Error outside of kernel. Not sure what is wrong.
> 
> Note that  if suspend after booting  with "single" (ie. with  only init,
> agetty and bash running) the other warnings go away, but I still see the
> above oops.

That's strange. It works here. I'm not sure whats wrong for you.

Also try to find out what you need to run if you want the warnings.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
