Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132775AbRC2QZf>; Thu, 29 Mar 2001 11:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRC2QXf>; Thu, 29 Mar 2001 11:23:35 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:4695 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132771AbRC2QXP>; Thu, 29 Mar 2001 11:23:15 -0500
Date: Thu, 29 Mar 2001 10:22:33 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103291622.KAA67155@tomcat.admin.navo.hpc.mil>
To: dwguest@win.tue.nl, Sean Hunter <sean-lk@dev.sportingbet.com>,
   linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW <dwguest@win.tue.nl>:
> 
> On Thu, Mar 29, 2001 at 01:02:38PM +0100, Sean Hunter wrote:
> 
> > The reason the aero engineers don't need to select a passanger to throw out
> > when the plane is overloaded is simply that the plane operators do not allow
> > the plane to become overloaded.
> 
> Yes. But today Linux willing overcommits. It would be better if
> the default was not to.

Preferably, the default should be a configure option, with runtime
alterations.

> > Furthermore, why do you suppose an aeroplane has more than one altimeter,
> > artifical horizon and compass?  Do you think it's because they are unable to
> > make one of each that is reliable?  Or do you think its because they are
> > concerned about what happens if one fails _however unlikely that is_.
> 
> Unix V6 did not overcommit, and panicked if is was out of swap
> because that was a cannot happen situation.

Ummm... no. The user got "ENOMEM" or "insufficient memory for fork", or
"swap error". The system didn't panic unless there was an I/O error on
the swap device.

> If you argue that we must design things so that there is no overcommit
> and still have an OOM killer just in case, I have no objections at all.

good.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
