Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSGCBPs>; Tue, 2 Jul 2002 21:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSGCBPr>; Tue, 2 Jul 2002 21:15:47 -0400
Received: from beach.cise.ufl.edu ([128.227.205.211]:3288 "EHLO
	mail.cise.ufl.edu") by vger.kernel.org with ESMTP
	id <S293203AbSGCBPr>; Tue, 2 Jul 2002 21:15:47 -0400
Date: Tue, 2 Jul 2002 21:18:11 -0400 (EDT)
From: Pradeep Padala <ppadala@cise.ufl.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace vs /proc
In-Reply-To: <aft582$mq0$1@abraham.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.44.0207022110160.23530-100000@lin116-01.cise.ufl.edu>
References: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu>
    <1024609747.922.0.camel@sinai> <20020702004706.GB107@elf.ucw.cz>
 <aft582$mq0$1@abraham.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Solaris /proc implementation, in contrast, was much cleaner,
> in my experience.  I suspect this is partially because the Solaris
> implementation was more carefully thought-through, but also the interface
> helped: by not overloading the meaning of signals, the Solaris /proc
> interface avoids changing the semantics of signal-related functionality
> in the traced process, and this makes for cleaner code.

I completely agree with you. Using ptrace to do user level extensions like
UFO(http://www.cs.ucsb.edu/projects/ufo/index.html) is grossly inefficient
and kludgy.

--pradeep

