Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTH2Qjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTH2Qjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:39:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4319 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261537AbTH2Qjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:39:46 -0400
Date: Fri, 29 Aug 2003 13:35:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ville Herva <vherva@niksula.hut.fi>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <Pine.LNX.4.55L.0308291325480.29088@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ville,
>
> Which kernel doesnt hang on your box? 2.4 something ?

> 2.4.20pre7 ran for over 9 months before it suddenly begun locking up (I
> _suppose_ it could just mean the bug/problem is hard to trigger.)
> Nothing had been changed: the box had been up for that nine month
> period, and the same oracle dump cron job had been running each night.

Strange.

> Earlier 2.4's had too many problems with aic7xxx (crashes and so on), so
> I can't comment on them.

> After 2.4.20pre7, I tried 2.4.21-jam1 (based on -aa patchset) and
> 2.4.22-pre8. I also tried compiling 2.4.21-jam1 with gcc-3.2.1 instead
> of 2.96. All of those locked up eventually, sometimes within a day from
> reboot, some times it takes weeks. At one point, 2.4.21-jam1 seemed to
> reliably lock up when compiling kernel, but it no longer happens no
> matter how hard I try. Usually the lock up happens during nightly oracle
> backup dump.

So NMI and sysrq doesnt help. I suggest you a few things:

Try to make the bug easy to reproduce. Force the Oracle dumps again and
again to crash the box. Can you try it or its a production machine?

BTW, can you describe this "Oracle dumps" in more detail? What do they do?
Save lots of data to disk and thats all or ?

Hope we can trace this down.
