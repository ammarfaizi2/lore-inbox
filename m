Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318245AbSG3Mfq>; Tue, 30 Jul 2002 08:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318246AbSG3Mfq>; Tue, 30 Jul 2002 08:35:46 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:63716 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318245AbSG3Mfq>; Tue, 30 Jul 2002 08:35:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Thomas Molina <tmolina@cox.net>
Subject: Re: 2.5.27: JFS oops
Date: Tue, 30 Jul 2002 07:38:49 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207291927160.19349-100000@dad.molina>
In-Reply-To: <Pine.LNX.4.44.0207291927160.19349-100000@dad.molina>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207300738.50302.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 19:33, Thomas Molina wrote:
> On Mon, 29 Jul 2002, Dave Kleikamp wrote:
> > On Monday 29 July 2002 10:06, Axel Siebenwirth wrote:
> > I haven't seen this trap before.  I'll take a closer look at it,
> > and let you know what I find.
> >
> > > Can I use jfs from cvs with current kernels
> > > (2.5.29/2.4.19-rc3-ac3) to see how latest changes work?
> >
> > Yes.  You should be able to just replace everything under fs/jfs
> > with what's in cvs.
>
> Are you saying jfs in 2.5.29 jfs is not a problem?  I'm looking to
> see if I should put it on my problem status report.

2.5.29 had a problem that is fixed in Linus's bk tree.  I had posted a 
patch to this list as well.  (Simply remove the calls to d_delete from 
namei.c.)

Axel is seeing traps that I haven't seen elsewhere, so that's another 
potential problem.  We don't know the cause of that one yet.

-- 
David Kleikamp
IBM Linux Technology Center

