Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUJHWJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUJHWJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUJHWJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:09:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:31420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265978AbUJHWJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:09:49 -0400
Date: Fri, 8 Oct 2004 15:09:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008150939.P2357@build.pdx.osdl.net>
References: <20041001142259.I1924@build.pdx.osdl.net> <1096669179.27818.29.camel@krustophenia.net> <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097273105.1442.78.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 08, 2004 at 06:05:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2004-10-08 at 17:52, Chris Wright wrote:
> > * Lee Revell (rlrevell@joe-job.com) wrote:
> > > On Fri, 2004-10-08 at 17:45, Chris Wright wrote:
> > > > > --- linux-2.6.8.1/security/realtime.c	Wed Dec 31 18:00:00 1969
> > > > > +++ linux-2.6.8.1-rt02/security/realtime.c	Mon Oct  4 21:35:41 2004
> > > > > +static int any = 0;			/* if TRUE, any process is realtime */
> > > > 
> > > > unecessary init to 0
> > > > 
> > > 
> > > I think gcc 3.4 complains otherwise.
> > 
> > Nah, it's fine.
> > 
> > $ grep 'int any' security/realtime.c
> > static int any;                 /* if TRUE, any process is realtime */
> > $ make security/realtime.o
> >   CC      security/realtime.o
> > $ gcc --version
> > gcc (GCC) 3.4.2 20040907 (Red Hat 3.4.2-2)
> 
> So MODULE_PARM_DESC is neccesary even when using module_param instear of
> MODULE_PARM?

YYeah, minor blemmish ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
