Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVFMQ15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVFMQ15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFMQ15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:27:57 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:13027 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261765AbVFMQ1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:27:43 -0400
Date: Mon, 13 Jun 2005 09:27:41 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Pausing a task
In-Reply-To: <20050613160449.GJ3008@lug-owl.de>
Message-ID: <Pine.LNX.4.58.0506130927040.12298@shell2.speakeasy.net>
References: <Pine.LNX.4.61.0506131142120.17826@chaos.analogic.com>
 <20050613160449.GJ3008@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, Jan-Benedict Glaw wrote:

> On Mon, 2005-06-13 11:50:34 -0400, Richard B. Johnson <linux-os@analogic.com> wrote:
> >
> > How can I (as root) pause or suspend a process?
> > On VAX/VMS one could do `set process=suspend`. This
> > would allow the system manager to check on a possibly
> > rogue user.
> >
> > Let's say that "Hacker Jack" just got fired because
> > he was disrupting a project. One needs to find any of
> > his processes where he might be deleting a project
> > tree. Pausing, rather than killing the tasks would
> > allow evidence to be gathered. Basically, I need
> > to set the task(s) priorities to something that
> > will take them out of the run-queue altogether.
>
> ~# pkill -SIGSTOP -U richard
>
> < examine the situation, attach gdb/strace/ltrace/whatever >
>
> If you just want to let'em continue:
>
> ~# pkill -SIGCONG -U richard

I think that's supposed to be "-SIGCONT" instead. :-)

> MfG, JBG
>
> --
> Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
> "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
>  fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!   O O O
> ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
>

-Vadim L
