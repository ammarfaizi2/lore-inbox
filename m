Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTIDPVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTIDPVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:21:14 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:14575 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S265065AbTIDPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:21:11 -0400
Subject: Re: nmi errors?
From: Martin Schlemmer <azarah@gentoo.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030903213417.GT7353@rdlg.net>
References: <20030903212038.GQ7353@rdlg.net>
	 <Pine.LNX.4.53.0309031724470.362@chaos>  <20030903213417.GT7353@rdlg.net>
Content-Type: text/plain
Message-Id: <1062688292.16818.148.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 04 Sep 2003 17:11:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 23:34, Robert L. Harris wrote:
> We ran "memtest" on the machine over the weekend and it completed 3
> times without any problems.  Know a better or different test?
> 

You might try to enable all the tests, addresses and set the
cache to be always on in memtest.  Typical keys pressed is:

  c - 1 - 2 - 2 - 3 - 3 - 3

Another is goldmemory, which is fairly the same in default setup
as memtest with above config, but shareware, not gpl.

> 
> Thus spake Richard B. Johnson (root@chaos.analogic.com):
> 
> > On Wed, 3 Sep 2003, Robert L. Harris wrote:
> > 
> > >
> > >
> > > Can anyone tell me what this is?
> > >
> > > 16:00:09 mailserver kernel: Uhhuh. NMI received for unknown reason 31.
> > > 16:00:09 mailserver kernel: Dazed and confused, but trying to continue
> > > 16:00:09 mailserver kernel: Do you have a strange power saving mode enabled?
> > > 16:00:34 mailserver kernel: Uhhuh. NMI received for unknown reason 21.
> > > 16:00:34 mailserver kernel: Dazed and confused, but trying to continue
> > >
> > > A coworker put a script on a server which loads up quite afew arrays
> > > with pre-set values and then compares the values against arrays.  As soon as he
> > > kicked off the script I got alot of these in my log files.  Not much longer and the
> > > machine crashed hard.
> > >
> > 
> > Possible bad RAM.
> > 
> > Cheers,
> > Dick Johnson
> > Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
> >             Note 96.31% of all statistics are fiction.
> > 
> 
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | GPG Key ID: E344DA3B
>                                          @ x-hkp://pgp.mit.edu
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
> 
> Life is not a destination, it's a journey.
>   Microsoft produces 15 car pileups on the highway.
>     Don't stop traffic to stand and gawk at the tragedy.
-- 
Martin Schlemmer


