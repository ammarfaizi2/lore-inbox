Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265205AbUELT4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUELT4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUELT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:56:30 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:8399 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265205AbUELT4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:56:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 May 2004 12:56:04 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Valdis.Kletnieks@vt.edu
cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up... 
In-Reply-To: <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com>
 <40A26FFA.4030701@pobox.com>            <20040512193349.GA14936@elte.hu>
 <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 12 May 2004 21:33:49 +0200, Ingo Molnar said:
> > 
> > * Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> > > >Woah, that's new.  And wrong.  The code in include/asm-i386/param.h that
> > > >says:
> > > >	# define JIFFIES_TO_MSEC(x)     (x)
> > > >	# define MSEC_TO_JIFFIES(x)     (x)
> > > >
> > > >Is not correct.  Look at kernel/sched.c for verification of this :)
> > > 
> > > 
> > > Yes, that is _massively_ broken.
> > 
> > why is it wrong?
> 
> If the kernel jiffie is anything other than exactly 1 msec, you're screwed... 

I believe they were talking about include/asm-i386/param.h
                                          ^^^^^^^^


- Davide

