Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLTJmt>; Wed, 20 Dec 2000 04:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLTJmk>; Wed, 20 Dec 2000 04:42:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28425 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129436AbQLTJmV>; Wed, 20 Dec 2000 04:42:21 -0500
Date: Wed, 20 Dec 2000 10:11:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
Message-ID: <20001220101142.A6234@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001217031814.A11954@pcep-jamie.cern.ch> <Pine.LNX.4.21.0012171624570.6706-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0012171624570.6706-100000@server.serve.me.nl>; from maillist@chello.nl on Sun, Dec 17, 2000 at 04:26:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How about adding a flag to FLAGS, or a new letter in STATE in
> > /proc/pid/stat, to mean "this is an idle task"?
> > 
> > ps & top could easily by taught to recognise the flag.
> 
> What's the problem with using PID 0 as the idle task ? That's 'standard'
> with OS'ses that display the idle task.

Linux has already another thread with pid 0, called "swapper" which is
in fact idle. kidle-apmd is different beast.

> It's also the 'right' thing to do, and should directly work with top / ps

Yes, we should make pid 0 visible to userlnad, agreed.

								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
