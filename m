Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSGUKli>; Sun, 21 Jul 2002 06:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSGUKli>; Sun, 21 Jul 2002 06:41:38 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:58118 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S311898AbSGUKli>; Sun, 21 Jul 2002 06:41:38 -0400
Date: Sun, 21 Jul 2002 11:10:47 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Alan Cox <alan@redhat.com>
cc: Adrian Bunk <bunk@fs.tum.de>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <200207200032.g6K0Wwk11011@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0207211008280.701-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, Alan Cox wrote:
> > How is assured that it's impossible to OOM when the amount of memory
> > shrinks?
> > IOW:
> > - allocate very much memory
> > - "swapoff -a"
>
> Make swapoff -a return -ENOMEM
>
> I've not done this on the basis that this is root specific stupidity and
> generally shouldnt be protected against

Recommended reading: MIT's Magazin of Innovation Technology Review,
August 2002 issue, cover story: Why Software Is So Bad?

Next you might read: "... prominent, leading Linux kernel developer
publically labels users stupid instead of handling a special case
[that is ironically used as a workaround for one of the many system
software deficiencies] in what case the system software would hang
using a new feature the developer is about to add and admitted to be
paid for ..."

Adrian would deserve a thanks for spotting and reporting the issue
[and there *are* other use cases for the above mentioned swapoff -a,
some also to overcome kernel bugs].

With all respect, Alan, the critic isn't personal but reaction to a
trendy phenomenon that should be address if developers care about user
issues.

	Szaka

