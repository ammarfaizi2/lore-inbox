Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWEMNSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWEMNSw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 09:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWEMNSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 09:18:51 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:58937 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932430AbWEMNSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 09:18:51 -0400
From: Mark Rosenstand <mark@borkware.net>
To: Theodore Tso <tytso@mit.edu>
Cc: doug@mcnaught.org, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: <20060513125911.GA2871@thunk.org>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
	<87r72yi346.fsf@suzuka.mcnaught.org>
	<20060513112754.1CA99146AF@hunin.borkware.net>
	<20060513125911.GA2871@thunk.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060513131850.2E732146AF@hunin.borkware.net>
Date: Sat, 13 May 2006 15:18:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> wrote:
> On Sat, May 13, 2006 at 01:27:54PM +0200, Mark Rosenstand wrote:
> > > Every Unix I've ever seen works this way.  It'd be nice to have
> > > unreadable executable scripts, but no one's ever done it.
> > 
> > According to
> > http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html both
> > 4.3BSD and SunOS have. I can confirm that it works on current BSD's
> > as well.
> 
> Incorrect.  The FAQ stated that BSD4.3 and SunOS support executable
> shell scripts, but both BSD 4.3 and SunOS required that the shell
> scripts be readable.  I know, I've personally worked on BSD 4.3
> systems and worked on BSD 4.3 source.  Read the FAQ more carefully....

I only confirmed that it works on current BSD's, not that it used to
work that way on 4.3BSD (although that was my impression.)

Anyhow, I don't really mind the 111 mode, the point was to show shell
scripts being treated as executables. What I do want this feature for
is the "more useful case" that somehow got stripped off in the replies,
namely setuid and setgid scripts.
