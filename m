Return-Path: <linux-kernel-owner+w=401wt.eu-S1753210AbWLUOWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbWLUOWo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbWLUOWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:22:44 -0500
Received: from smtp.nildram.co.uk ([195.112.4.54]:3343 "EHLO
	smtp.nildram.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbWLUOWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:22:43 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
Date: Thu, 21 Dec 2006 14:22:32 +0000
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200612210308_MC3-1-D5D4-3328@compuserve.com>
In-Reply-To: <200612210308_MC3-1-D5D4-3328@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612211422.32650.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 December 2006 08:05, Chuck Ebbert wrote:
> In-Reply-To: <200612202215.50315.s0348365@sms.ed.ac.uk>
>
> On Wed, 20 Dec 2006 22:15:50 +0000, Alistair John Strachan wrote:
> > > I'd guess you have some kind of hardware problem.  It could also be
> > > a kernel problem where the saved address was corrupted during an
> > > interrupt, but that's not likely.
> >
> > Seems pretty unlikely on a 4 year old Via Epia. Never had any problems
> > with it before now.
> >
> > Maybe a cosmic ray event? ;-)
>
> The low byte of eip should be 5f and it changed to 60, so that's
> probably not it.  And the oops report is consistent with that being
> the instruction that was really executed, so it's not the kernel
> misreporting the address after it happened.
>
> You weren't trying kprobes or something, were you? Have you ever
> had another unexplained oops with this machine?

Nope, it's a stock kernel and it's running on a server, kprobes isn't in use.

And no, to my knowledge there's not been another "unexplained" oops. I've had 
crashes, but they've always been known issues or BIOS trouble.

The machine was recently tampered with to install additional HDDs, but the 
memory was memtest'ed when it was installed and passed several times without 
issue. I'm rather puzzled.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
