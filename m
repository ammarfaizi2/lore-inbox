Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273298AbTHPPDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273272AbTHPPDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:03:35 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:28324 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S273244AbTHPPDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:03:33 -0400
Date: Sun, 17 Aug 2003 01:03:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: rob@landley.net, george@mvista.com, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
Subject: Re: APM and 2.5.75 not resuming properly
Message-Id: <20030817010320.0668d246.sfr@canb.auug.org.au>
In-Reply-To: <20030816142933.GE23646@mail.jlokier.co.uk>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
	<200308132024.36967.rob@landley.net>
	<3F3B41C7.1000906@mvista.com>
	<200308160510.44627.rob@landley.net>
	<20030816142933.GE23646@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 15:29:33 +0100 Jamie Lokier <jamie@shareable.org> wrote:
>
> Rob Landley wrote:
> > (APM suspends, and then never comes back until you yank the #*%(&#
> > battery.  Great.  Trying it with the real mode bios calls next
> > reboot...)
> 
> Similar here.  Using 2.5.75.  APM with no local APIC (kernel is unable
> to enable it anyway).
> 
> It suspends.  On resume, the screen is blank and the keyboard doesn't
> respond (no Caps Lock or SysRq).  Occasionally when it resumes the
> keyboard does respond, but the screen stays blank.  At least it is
> possible to do SysRq-S SysRq-B in this state.  Sometimes, if I'm
> lucky, I can make it reboot by holding down the power key for 5 seconds.

I may have missed somthing, but let me ask anyway: What laptop? Have you
tried switching to a text console before suspending?  Have you tried
	Options "NoPM" "True"
in the ServerFlags section of your XF86Config?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
