Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133086AbRDZNss>; Thu, 26 Apr 2001 09:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135396AbRDZNsh>; Thu, 26 Apr 2001 09:48:37 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:33664 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S133086AbRDZNsa>; Thu, 26 Apr 2001 09:48:30 -0400
Date: Thu, 26 Apr 2001 15:47:42 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: imel96@trustix.co.id
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010426154742.O20175@tux.bitfreak.net>
In-Reply-To: <3AE7EE6F.28446A2C@idb.hist.no> <Pine.LNX.4.33.0104261730510.1677-100000@tessy.trustix.co.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0104261730510.1677-100000@tessy.trustix.co.id>; from imel96@trustix.co.id on Thu, Apr 26, 2001 at 13:31:54 +0200
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.26 13:31:54 +0200 imel96@trustix.co.id wrote:
> On Thu, 26 Apr 2001, Helge Hafting wrote:
> > The linux kernel ought to be flexible, so most people can use
> > it as-is.  It can be used as-is for your purpose, and
> > it have been shown that this offer more security _without_
> > inconvenience.  Your patch however removes multi-user security
> > for the many who needs it - that's why it never will get accepted.
> > Feel free to run your own patched kernels - but your
> > patch will never make it here.
> 
> i don't understand, that patch is configurable with 'n' as
> default, marked "dangerous". so somebody who turned on that
> option must be know what he's doing, doesn't understand english,
> or has a broken monitor.

I can make a virus, patch the kernel and send it in, with a 'N' by default.
But what is the use of this? Do you think this will be implemented???

Your thing is as dangerous as a virus, basically. It gives root to
everyone, although they have separate UIDs. And whenever there is a way out
(i.e. surfing the web, reading mail), there is a way in. So that would make
your system a very nice target to hack -> since you basically are root this
means they can change anything as soon as they have access. If you're not
root, they can't, since they can only do what you as a user can do.
The whole goal of your patch is to make computer life easier. This patch
doesn't do that - it goes far worse. We gave you a few suggestions on
better/easier ways to accomplish this goal - take them as advice and use
them instead.

Easy: chmod -R 777 / (same risk, though)
Good: use su for installing software (su -c "make install")

Can't get much easier than that (and if a clueless user needs to do this,
let him use redhat's RPM manager, "enter your password" with a nice
X-window, and press that button  "install" - same effect)...

You don't need to patch the kernel for this...

--
Ronald Bultje

