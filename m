Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270577AbRHIUFk>; Thu, 9 Aug 2001 16:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270578AbRHIUF3>; Thu, 9 Aug 2001 16:05:29 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:51464 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S270577AbRHIUFS>; Thu, 9 Aug 2001 16:05:18 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <9kpub6$8fu$1@ns1.clouddancer.com>
In-Reply-To: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org> <m3g0b3v8zq.fsf@flash.localdomain> <9kpub6$8fu$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010809200529.96DF178616@mail.clouddancer.com>
Date: Thu,  9 Aug 2001 13:05:29 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>Hi Mark.
>
> >>> Described above.
>
> >> What KERNEL problems then? I don't see any yet.
>
> > I smell the stench of finger pointing. It's a pity that it
> > stinks jsut as bad in the open source world as it is I am
> > "privileged" when closed source shops, or (even worse)
> > telco/network folks start playing "blameball".
>
>I'm trying not to point any fingers anywhere, but I have to admit that
>I'm finding it VERY difficult in this case. The basic problem that I
>have is that the "way it's done" that I referred to in my posts so far
>is the way that RedHat, Caldera, Debian, Mandrake, SUSE and Eridani
>Linux all do it by default (I can't comment on SlackWare as I've never
>been able to get it to install myself and don't know anybody who runs
>it).


Takes about 5 minutes to setup a Slackware install and about 3 minutes
after floppy boot to install it.  Init scripts are not SysV
(wonderful!), nor do they contain some of the Redhat silliness ( ">
/etc/mtab" is stupid, dies everytime something eariler in the kernel
gets upset).  But the init scripts do not handle multiple interfaces
out of the box either.

My answer has always been a combination of built-in interfaces (for
the default routes), modules, and either all unique cards or all the
same.  It's custom and works fine until the hardware is changed...  A
general solution would be appreciated.

