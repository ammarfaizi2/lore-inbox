Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUC3JdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUC3JdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:33:18 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:47065 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263573AbUC3JdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:33:13 -0500
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc2-mm5
Date: Tue, 30 Mar 2004 11:40:19 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040329014525.29a09cc6.akpm@osdl.org> <200403301127.35263.rjwysocki@sisk.pl> <20040330012404.34012b35.akpm@osdl.org>
In-Reply-To: <20040330012404.34012b35.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301140.19083.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of March 2004 11:24, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > On Monday 29 of March 2004 11:45, Andrew Morton wrote:
> > > +remove-down_tty_sem.patch
> > > +tty-locking-again.patch
> >
> > These two patches break things quite a bit for me.  With them, the kernel
> > is unable to open any tty (virtual console, pts, whatever), it seems (my
> > system is a dual AMD64 w/ NUMA w/o kernel preemption).
>
> yup.  Please revert tty-locking-again.patch.  Or just do
> rm drivers/char/tty* and start again.

I've already done it.  I mean, I've reverted both patches and now it's OK (I 
was not quite sure if there's any point in reverting only one of them).

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
