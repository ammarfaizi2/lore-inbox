Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVAVDLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVAVDLt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 22:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVAVDLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 22:11:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:47556 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262659AbVAVDLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 22:11:38 -0500
Date: Fri, 21 Jan 2005 19:11:36 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: <dev@osdl.org>, <linux-kernel@vger.kernel.org>,
       <stp-devel@lists.sourceforge.net>
Subject: Re: [LTP] Re: [Dev] Re: Kernel Panic with LTP on 2.6.11-rc1 (was
 Re: LTP Results for 2.6.x and 2.4.x)
In-Reply-To: <Pine.LNX.4.33.0501211706430.32650-100000@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0501211838240.32650-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Bryce Harrington wrote:
> On Fri, 21 Jan 2005, Chris Wright wrote:
> > * Andrew Morton (akpm@osdl.org) wrote:
> > > Bryce Harrington <bryce@osdl.org> wrote:
> > > I am unable to find the oops trace amongst all that stuff.  Help?
> > >
> > > (It would have been handy to include it in the bug report, actually)
> >
> > Yes, it would.  Or at least some better granularity leading up to the
> > problem.  I ran growfiles locally on 2.6.11-rc-bk and didn't have any
> > problem.  Could you strace growfiles and see what it was doing when it
> > killed the machine?
>
> Okay, I'll set up another run and try collecting that info.  Is there
> any other data that would be useful to collect while I'm at it?

Well, I'm not having much luck.  strace isn't installed on the system
(and is giving errors when trying to compile it).  Also, the ssh session
(and sshd) quits whenever I try running the following growfiles command
manually, so I'm having trouble replicating the kernel panic manually.

# growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2

Anyway, if anyone wants to investigate this further, I can provide
access to the machine (email me).  Otherwise, I'm probably just going to
wait for -rc2 and see if the problem's still there.

Thanks,
Bryce



