Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312738AbSCVQDS>; Fri, 22 Mar 2002 11:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312739AbSCVQDJ>; Fri, 22 Mar 2002 11:03:09 -0500
Received: from Expansa.sns.it ([192.167.206.189]:9486 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312738AbSCVQCy>;
	Fri, 22 Mar 2002 11:02:54 -0500
Date: Fri, 22 Mar 2002 17:02:55 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810 (reiserFS related?)
In-Reply-To: <20020322085128.B6792@namesys.com>
Message-ID: <Pine.LNX.4.44.0203221702380.12514-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanx,
it works ;)


On Fri, 22 Mar 2002, Oleg Drokin wrote:

> Hello!
>
> On Thu, Mar 21, 2002 at 06:41:49PM +0100, Luigi Genoni wrote:
>
> > It seems that a lot of users had oops mounting reiserFS with 2.5.6, but
> > then a patch fixed that. Now I think this patch is in 2.5.7, (it should),
> > but there are other changes i think to reiserFS code. So i have other
> > oopses.
>
> reiserfs in 2.5.6-pre3 to 2.5.7 have a bug that prevent it from mounting
> usual filesystems (filesystems with relocated journals still works,
> but I doubt much people use that).
>
> > I think this could be a proof of a reiserFS bug.
>
> Sure.
>
> > If people at namesys need it (maybe they already know this, and have a
> > patch to try), tomorrow i will post the oop mounting
> > reiserFS.
>
> No need for that. See attached patch that I am posting in response to
> any such report (so just looking in archives first might help you faster).
>
> Bye,
>     Oleg
>

