Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272266AbTGYTZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTGYTZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:25:28 -0400
Received: from smtp.mailix.net ([216.148.213.132]:24946 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S272266AbTGYTZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:25:23 -0400
Date: Fri, 25 Jul 2003 21:40:29 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030725194029.GA1893@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20030718073842.GA5598@Synopsys.COM> <Pine.LNX.4.44.0307251628500.26172-300000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307251628500.26172-300000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terribly sorry for delay. I got a bit distracted by some elements of
testing (dvd playing).

Ingo Molnar, Fri, Jul 25, 2003 16:29:33 +0200:
> > Still no good. xine drops frames by kernel's make -j2, xmms skips while
> > bk pull (locally). Updates (after switching desktops in metacity) get
> > delayed for seconds (mozilla window redraws with www.kernel.org on it,
> > for example).
> 
> would you mind to give the attached sched-2.6.0-test1-G2 patch a go? (it's
> ontop of vanilla 2.6.0-test1.) Do you still see audio skipping and/or
> other bad scheduling artifacts?

Started make -j2 (my machine is UP), xine-distractor and gvim.
Moving gvim window over xine (even if paused) is jerky, but tolerable.
No skips during playing. No at all. Redraws in MozillaFirebird are
delayed (I get trails all over the firebird window), but again - no
annoyingly long delays.

I continue testing.

> (if you prefer -mm2 then please first unapply the second attached patch
> (Con's interactivity patchset) - they are mutually exclusive.)

I used the G2 on 2.6-test1.


-alex

