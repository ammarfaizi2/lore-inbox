Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTAHAqa>; Tue, 7 Jan 2003 19:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267616AbTAHAqa>; Tue, 7 Jan 2003 19:46:30 -0500
Received: from cibs9.sns.it ([192.167.206.29]:12 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267615AbTAHAq3>;
	Tue, 7 Jan 2003 19:46:29 -0500
Date: Wed, 8 Jan 2003 01:54:45 +0100 (CET)
From: venom@sns.it
To: Larry McVoy <lm@bitmover.com>
cc: Matthias Andree <matthias.andree@gmx.de>, <linux-kernel@vger.kernel.org>,
       <andre@linux-ide.org>
Subject: Re: Honest does not pay here ...
In-Reply-To: <20030108003050.GF17310@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0301080152130.25245-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


well, I was forgetting to specify,
queues are kernel threads, and that is quite
optimum expecially on SMP systems.
One big advantage is that conflicts possibilities are
(should be) less than minimal.

Luigi

On Tue, 7 Jan 2003, Larry McVoy wrote:

> Date: Tue, 7 Jan 2003 16:30:50 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: venom@sns.it
> Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
>      andre@linux-ide.org
> Subject: Re: Honest does not pay here ...
>
>
> > In very semplicistic words:
> > In 2.5/2.6 kernels, non GPL modules have a big
> > penalty, because they cannot create their own queue, but have to use a default
> > one.
>
> I may be showing my ignorance here (won't be the first time) but this makes
> me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> drivers which ran in kernel mode but in the context of a process and had
> to talk to the real kernel via pipes or whatever.  It's a fair amount of
> plumbing but could have the advantage of being a more stable interface
> for the drivers.
>
> If you think about it, drivers are more or less open/close/read/write/ioctl.
> They need kernel privileges to do their thing but don't need (and shouldn't
> have) access to all the guts of the kernel.
>
> Can any well traveled driver people see this working or is it nuts?
> --
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
>

