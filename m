Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVIRRWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVIRRWb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVIRRWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:22:31 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:51372 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932128AbVIRRWa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:22:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KDKaw+zIs5WZ8dMhdjRfbALhgKj2X7DM6skOak84uLcP1Cp1HAjkdcfuLGRIpMMgxsOpG/hE+EckuAXUxZ85aVeYPPkITiMfb6WF9FKk46lNNQMpwU8D0UyKWM+imNc63q4EnvL8aiGg1C9yvlW/JAcsVjqwb4iFOzXgV6c6LEE=
Message-ID: <b14e81f0050918102254146224@mail.gmail.com>
Date: Sun, 18 Sep 2005 13:22:27 -0400
From: michael chang <thenewme91@gmail.com>
Reply-To: thenewme91@gmail.com
To: Christoph Hellwig <hch@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       chriswhite@gentoo.org, Hans Reiser <reiser@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
In-Reply-To: <20050918102658.GB22210@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432AFB44.9060707@namesys.com>
	 <200509171415.50454.vda@ilport.com.ua>
	 <200509180934.50789.chriswhite@gentoo.org>
	 <200509181321.23211.vda@ilport.com.ua>
	 <20050918102658.GB22210@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Sun, Sep 18, 2005 at 01:21:23PM +0300, Denis Vlasenko wrote:
> > This is it. I do not say "accept reiser4 NOW", I am saying "give Hans
> > good code review".
> 
> After he did his basic homework.  Note that reviewing hans code is probably
> at the very end of everyones todo list because every critizm of his code
> starts a huge flamewar where hans tries to attack everyone not on his
> party line personally.
> 
> I've said I'm gonna do a proper review after he has done the basic homework,
> which he seems to have half-done now at least.  Right now he hasn't finished

Explain to us all what is this "basic homework" of which you speak.

> that and there's much more exciting filesystems like ocfs2 around that

This is exciting to... whom?  The only thing that appears remotely
interesting about it is that it's made by Oracle and apparently is
supposed to be geared toward parallel server whatsits.  This might be
helpful to corporations, but seems senseless toward many consumers. 
(I'm assuming there's still at least one consumer left who still uses
Linux.)

> are much easier to read and actually have developers that you can have
> a reasonable conversation with.  (and that unlike hans actually try to

Is that Hans' fault, or the fault of your lot?  Why can't we all just get along?

Give Hans a chance; and please try to understand, even if he's hard to
work with.  Discriminate him because he's not a developer you can talk
with, and I believe that's like discriminating a guy in a wheelchair
because he can't run with you when you jog in the morning.

> improve core code where it makes sense for them)

Not everyone has the same "common sense" that you do.  Explain, fully,
with reasoning, and reproducable back-up statistics on common
hardware, what code is wrong, and what must be written instead.  We'd
like to be efficient, and it's not being efficient to play a guessing
game with us.  If you don't have the time to review, then please hold
off on replying until you have a through review of at least part of
the code.

Unless you object fully to one particular, fixable thing that isn't
the core of Reiser4, it'd be nice for you to wait on replying --
vagueness is not helpful to development in any way.  Are we supposed
to be the million monkeys randomly typing on a million typewriters
waiting for someone to give you code that you like, one in a million
years?

Also, let's say that Reiser4 doesn't get into the kernel, as maybe XFS
or ext2 or ext3 had never gotten into the kernel.  How would their
development be now as opposed to how we see it, when they have gotten
into the kernel?  I don't see anything wrong with the idea of letting
what seems a mostly mature FS into the kernel; that is how most bugs
are found in the first place.  Of course, there is nothing wrong with
putting huge warnings on the FS; I'd recommend them, considering that
some people are having funky problems with the patch.

I'm willing to go compare Reiser4 to ext2/3 as like H.264 to Mpeg-2. 
Indeed, H.264 crashes some computers, similar to Reiser4 might crash
some machines, but this is merely because Reiser4 explores new
concepts, meaning it may require hardyier hardware than ext2/3, as
H.264 requries hardier hardware than Mpeg-2.  I believe that the
concept is the same. (And all the same, media companies are embracing
H.264 - why can't you guys embrace this new idea also?) Change is
hard.  Besides, if Reiser4 is truely that flawed, we will see in a few
releases, and then afterwards if it's proven to everyone that Reiser4
is completely unrepairable and hopeless, it can then be ditched and
thrown into the trash.

My apologies for my rudeness, but I am rather fond of the developments
in Reiser4, and would love to see it in the kernel.  I am fond of
Linux too, and the work that you guys do, and it would dissapoint me
sorrily if Reiser4 never makes it into the Linux kernel.  Feel free to
say I'm a tad biased; I will say now that I probably have much less
merit in the field than you guys do.

-- 
~Mike
 - Just my two cents
 - No man is an island, and no man is unable.
