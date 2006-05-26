Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWEZR2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWEZR2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWEZR2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:28:17 -0400
Received: from xenotime.net ([66.160.160.81]:45283 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751192AbWEZR2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:28:16 -0400
Date: Fri, 26 May 2006 10:28:13 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, drepper@redhat.com,
       akpm <akpm@osdl.org>, serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com,
       dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
In-Reply-To: <20060526144216.GZ13513@lug-owl.de>
Message-ID: <Pine.LNX.4.58.0605261025230.9655@shark.he.net>
References: <20060525204534.4068e730.rdunlap@xenotime.net>
 <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006, Jan-Benedict Glaw wrote:

> On Fri, 2006-05-26 03:14:06 -0600, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> > > This patch is against 2.6.17-rc5, for review/comments, please.
> > > It won't apply to -mm since Andrew has merged the uts-namespace patches.
> > > I'll see about merging it with those patches next.
> > > ---
> > >
> > > From: Randy Dunlap <rdunlap@xenotime.net>
> > >
> > > Implement POSIX-defined length for 'hostname' so that hostnames
> > > can be longer than 64 characters (max. 255 characters plus
> > > terminating NULL character).
> > >
> > > Adds sys_gethostname_long() and sys_sethostname_long().
> > > Tested on i386 and x86_64.
> >
> > Is there any particular reason for this?
> > The existing sys_gethostname and sys_sethostname interfaces
> > should work for any string length.
> >
> > Although I do agree that we need at least one new syscall
> > for the architectures that don't currently use get_hostname.
>
> ...and this should have gone to linux-arch, too...

so how does someone know:
(a) that this should have gone to linux-arch
(b) that linux-arch exists
(c) what it's full email address it?

I.e., where is all of this explained?

Thanks.
-- 
~Randy

I'll get to Eric's questions later.  I'm in a meeting today.
