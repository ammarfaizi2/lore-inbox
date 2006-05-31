Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWEaEMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWEaEMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWEaEMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:12:36 -0400
Received: from smtp.enter.net ([216.193.128.24]:10506 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751654AbWEaEMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:12:35 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 31 May 2006 00:11:22 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605302314.25957.dhazelton@enter.net> <9e4733910605302102y491de627n7dabfbda0ed365b1@mail.gmail.com>
In-Reply-To: <9e4733910605302102y491de627n7dabfbda0ed365b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605310011.22902.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 04:02, Jon Smirl wrote:
> On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> > On Tuesday 30 May 2006 23:27, Jon Smirl wrote:
> > > On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> > > > Actually the suspend/resume has to be in userspace, X just re-posts
> > > > the video ROM and reloads the registers... so the repost on resume
> > > > has to happen... so some component needs to be in userspace..
> > >
> > > I'd like to see the simple video POST program get finished. All of the
> > > pieces are lying around. A key step missing is to getting klibc added
> > > to the kernel tree which is being worked on.
> >
> > True. But how long is it going to be before klibc is merged?
>
> The merged tree is here:
> git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

At the moment I don't have a connection that makes gits useful... I'm hoping 
to upgrade my connection within the next two months, but finances (for me) 
are never certain because bills come in seemingly at random.

> I don't know the plans for when the final merge will happen.
>
> A standalone version of klibc is also available here:
> http://www.kernel.org/pub/linux/libs/klibc/
> Looks like version 1.3 is the latest

I'll have to install it, then. But none of my work in the kernel is going to 
depend on it until it is merged into Linus' tree.

> The standalone version is perfectly fine for development. You only
> need to worry about the kernel tree version when it everything is
> finished. I've used klibc for several apps like this and it is a great
> tool. The binaries it produces are tiny.
>
> vbetool is a good way to practice resetting the cards if you do the
> mods to /sys/class/firmware. The other features like emu86 support can
> be added later.

As I said, I will be taking a look at it in the hopes that I can assist them 
once I get most of the framework layed down.

DRH
