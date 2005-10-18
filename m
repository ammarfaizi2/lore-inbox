Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVJROZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJROZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJROZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:25:19 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:51330 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750757AbVJROZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:25:18 -0400
From: Michael Neuffer <neuffer@neuffer.info>
Date: Tue, 18 Oct 2005 16:30:02 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 dead in early boot
Message-ID: <20051018143002.GA6287@neuffer.info>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051017210609.GA30116@aitel.hist.no> <20051017140906.0771f797.akpm@osdl.org> <20051017215343.GA30829@aitel.hist.no> <20051017173804.1529e3e6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017173804.1529e3e6.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >
> > On Mon, Oct 17, 2005 at 02:09:06PM -0700, Andrew Morton wrote:
> >  > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >  > >
> >  > > This one gets me a penguin on the framebuffer, and then dies
> >  > > with no further textual output.  
> >  > > numlock leds were working, and I could reboot with sysrq.
> >  > 
> >  > Can we get anything useful out of sysrq-p and sysrq-t?
> >  > 
> >  > Also, adding initcall_debug to the boot command line might help.
> >  > 
> >  Tried again without the framebuffer.  Still hanging, but more info:
> > 
> >  Last messages before getting stuck:
> >  md autorun DONE
> >  kjournald starting
> >  Ext3-fs mounted fs w. ordered data mode
> >  VFS mounted root (ext3) read-only
> >  freeing unused kernel memory 216k freed.
> >  warning-unable to open an initial console
> >  kernel panic-not syncing:No init found. Try passing init= option to kernel
> > 
> > 
> >  Somewhat silly. There certainly was a console (vgacon) or I wouldn't
> >  be able to read the messages.  And if it mounted root, then there certainly
> >  was an init to run also.
> 
> Can you send the .config please?

I see the same effect, with the only difference
that I don't get the kernel panic line.
For me it gets stuck after the "warning-unable to open an initial console"

I'll send you the .config in a seperate mail.

Cheers
   Mike
