Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTDYVtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDYVtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:49:45 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:47599 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263713AbTDYVtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:49:43 -0400
Date: Fri, 25 Apr 2003 15:06:09 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: James Strandboge <jamie@tpptraining.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: odd gnome-terminal behavior in 2.5.67-mm3
Message-ID: <20030425130609.GI6009@wind.cocodriloo.com>
References: <Pine.LNX.4.44.0304241518550.31091-100000@sol.cobite.com> <1051277058.1588.70.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051277058.1588.70.camel@sirius.strandboge.cxm>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 09:24:18AM -0400, James Strandboge wrote:
> On Thu, 2003-04-24 at 15:26, David Mansfield wrote:
> > Hi Andrew, list
> > 
> > I've been experiencing some odd behavior running 2.5.67-mm3 on my RH9 
> > based desktop.
> > 
> > It's probably an application bug, but something strange is happening 
> > anyway that doesn't happen in 'stable' kernels.
> > 
> > What happens is that gnome-terminal gets stuck in some sort of 'infinite 
> > loop' when a lot of output is going to the screen and also keypresses are 
> > going in (like paging through a large file - holding down pgup/pgdown).
> > 
> > Xterm doesn't seem to be affected.
> 
> I'll chime in and mention that I've seen this too, and also doing a
> paste operation via highlight and middle click doesn't work in 2.5
> either.  I assumed it was a libvte bug.

I've experienced this also when running "make menuconfig"
against 2.5.66 while running 2.5.66 on a redhat9 system.

I filled a bug-report on bugzilla.rehat.com and
they told me "bug is reproduced here. workaround is to
minimize the gnome-terminal while there is intense
terminal activity"... so I'm supposed to config my
kernel while it's terminal is not visible... great :)

I'd not mind trying to debug gnome-terminal if
I didn't need to install bazillons of libs
for his recompile...
