Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTLXEPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 23:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTLXEPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 23:15:14 -0500
Received: from dp.samba.org ([66.70.73.150]:12177 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263053AbTLXEPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 23:15:06 -0500
Date: Wed, 24 Dec 2003 15:13:14 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Bradley W. Allen" <ULMO@Q.NET>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: DevFS vs. udev
Message-Id: <20031224151314.700680fe.rusty@rustcorp.com.au>
In-Reply-To: <E1AYl4w-0007A5-R3@O.Q.NET>
References: <E1AYl4w-0007A5-R3@O.Q.NET>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 03:51:58 -0800
"Bradley W. Allen" <ULMO@Q.NET> wrote:

> DevFS was written by an articulate person who solved a lot of
> problems.  udev sounds more like a thug who's smug about winning,
> not explaining himself, saying things like "oh, the other guy
> disappeared, so who cares, you have to use my code, too bad it sucks".

Badley, you've made an unvaluable contribution today.  The least I can
do is punctuate your words with my own thoughts, below:

> *  User space is slow, causing all sorts of extra work for device
>    accesses.

Hey, I didn't realize that!  It seems so unlikely.

> *  Another layer of filesystem for udev to have to interact with
>    is also slow, especially if it has to be disk based with all sorts
>    of extra caches, and also if it's with buggy tmpfs code and layers.

I hear you: if it were slow and buggy, it *would* be slow and buggy.
I had never really thought of it in that way before.

> *  Most of the interesting devices I have now are character devices,
>    and have multiple potential /dev entries per device.  I've heard
>    that udev can't even handle that requirement!

Now, I've heard that too!

>    Udev has lots of other problems, like something called an anonymous
>    device, and it not being fully implemented, however, that's OK for
>    development.  We're in 2.6.0, now, so that's not OK!  DevFS has been
>    solid for over half a decade, so it belongs in stable kernels.

And who's thinking about the poor users?  Their upturned faces, full of
trust and love: their shining lack of experience, unstained by harsh
knowledge of programming realities.  These people have needed a voice:
a hero if you will.

> *  Userspace is not the proper place for kernel device drivers or
>    anything they need to work.

Agreed.  Not to put it too harshly, these "kernel hackers" are cruel
overlords, jealously guarding their free code from the users who need it.

It's time for the USERS to rise up and speak.  But who will speak for
them?  Who?

> *  We do not need the same old maintainer for devfs.  We can create
>    new code, and maintain old code, as a group, ourselves.

You're right: WE know what we want!  All we need is someone like US:
close to the users, NOT close to the code!

> *  Viro also said that devfs had been "shoved" into the tree, and
>    that it "had stayed around for many months".  It's been stable for
>    many *YEARS*, for most of a *DECADE*.

This Viro, he's another one of these oppressive "coders", right?
It seems pretty clear that we need LESS coders making technical
decisions which effect users, an MORE users making technical
decisions!

> I've spent two hours on this problem, and that's absurd

After reading the precision and sophistication of your prose, your
grasp of technical content is clear.  Finding out that you'd spent two
hours on *anything* technical is shocking to me.

> Luckily, this is just software, so we can do what we want with it, but
> organizationally it is conceptually just as bad.

Reading this last sentence brought tears to my eyes.  Really.

I think I speak for most people on this list when I say that the kernel
NEEDS people like you like we need devfs itself.  I remember in 2.3, when
we all needed devfs badly, and that's how we got it: we needed it, and
it went in.  Now those same people who didn't want it in the first place
want it removed.

Badley, I ask you in all seriousness: will you take up the challenge,
and fill the gaping hole which we've all felt for so long in the Linux
community?  To give raw, unvarnished feedback, unconfused by the
complexities of code?

I, for one, see the future lies in your posts.
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
