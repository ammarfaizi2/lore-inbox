Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSHaQQ5>; Sat, 31 Aug 2002 12:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSHaQQ4>; Sat, 31 Aug 2002 12:16:56 -0400
Received: from dsl-213-023-039-014.arcor-ip.net ([213.23.39.14]:56295 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317616AbSHaQQz>;
	Sat, 31 Aug 2002 12:16:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
Date: Sat, 31 Aug 2002 18:13:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
References: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com> <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lArx-0004PK-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 02:51, Alan Cox wrote:
> On Sat, 2002-08-31 at 01:49, Linus Torvalds wrote:
> > > struct pcred {
> > >        atomic_t	count;
> > >        uid_t	uid, euid, suid;
> > >        gid_t	gid, egid, sgid;
> > >        struct ucred  *cred;
> > >        kernel_cap_t ... capabilities ...
> > >        struct user_struct *user;
> > > };
> > 
> 
> Needs fsuid too, and space for the security LSM modules to attach
> private information. SELinux needs a few more credentials than base
> kernels!

Why worry about what SELinux needs, since it is proprietary, and may
not even be legal to distribute?  Perhaps there is some other set of
security plugins that actually matter.

-- 
Daniel
