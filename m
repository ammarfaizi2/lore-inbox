Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVLHCY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVLHCY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 21:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVLHCY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 21:24:28 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:6470 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932542AbVLHCY1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 21:24:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=LU/GimoybScZ2jMzl5jBmFPoIg5qKUx+lKV8dwi2KeLFU3huFeAYf9U3prgyhGLtfpaIHxR6osHnvy68+tPI6dkgKRpkq9tkjMvulItTDefSr9Gu0NFNGf7OnNKggA0lrDi2LJXE6yS+BTD6hnYn6O5GqYEkE75JuYBYscgyJNA=
Date: Thu, 8 Dec 2005 03:24:04 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: nicolas.mailhot@laposte.net, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-Id: <20051208032404.8bad585a.diegocg@gmail.com>
In-Reply-To: <1134003536.8162.4.camel@localhost>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<20051205121851.GC2838@holomorphy.com>
	<20051206011844.GO28539@opteron.random>
	<43944F42.2070207@didntduck.org>
	<20051206030828.GA823@opteron.random>
	<f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	<1133869465.4836.11.camel@laptopd505.fenrus.org>
	<4394ECA7.80808@didntduck.org>
	<1133880581.4836.37.camel@laptopd505.fenrus.org>
	<loom.20051206T220254-691@post.gmane.org>
	<1134003536.8162.4.camel@localhost>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 08 Dec 2005 01:58:56 +0100,
Kasper Sandberg <lkml@metanurb.dk> escribió:


> i disagree, you make it sound like it takes weeks of effort to find out
> which stuff works on linux, and that basically you have to be lucky to
> find it at all...
> 
> basically the only thing that doesent work (i dont count binary-only
> solutions working) is nvidia and ati.

Agreed - I know several people who has bought "exotic" laptops and
everything (sound, usb, irda, firewire, ethernet, pcmcia slots) except 
video cards worked out-of-the box using distros like ubuntu

Many times Windows XP requires inserting the CDs with 3rd party drivers.

IMO the way linux is doing things is the Right Way: Hardware should
work out of the box, and things like the windows' panel control driver
dialogs are a failure because users should't care about low-level
things like installing drivers. The "works under linux logo" is
misleading because a given device may not have such logo and
it may have been supported by a recent kernel version or it may
work only with a distro or things like that.


Companies like adaptec are collaborating in creating open source
drivers since linux became relevant in servers because companies
understood that their devices need to support linux properly
if they want to get money. IMO it will happen the same with desktops
once linux gets a decent part of the market share if people keeps the
same pressure on them.

The main problem right now are graphic chips, but IMHO that's because
right now there's a "revolution" in the graphics market: programmable
GPUs, 3d-hardware-accelerated desktops and all that, but i think
it'd be reasonable to expect that it'll settle down after a few years
and it will be easier to write drivers for them (today you can
reverse engineer a device but ati will release a new and revamped
chip in six months etc.)
