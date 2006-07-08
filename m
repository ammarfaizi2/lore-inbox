Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWGHTZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWGHTZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWGHTZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:25:04 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:58558 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030256AbWGHTZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:25:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sat, 8 Jul 2006 21:25:12 +0200
User-Agent: KMail/1.9.3
Cc: Sunil Kumar <devsku@gmail.com>, Bojan Smojver <bojan@rexursive.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org>
In-Reply-To: <1152377434.3120.69.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607082125.12819.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 18:50, Arjan van de Ven wrote:
> On Sat, 2006-07-08 at 09:42 -0700, Sunil Kumar wrote:
> >         Multiple all-half-working implementations is insane. It means
> >         bugs don't
> >         get fixed, it means there isn't going to be ANY implementation
> >         that is 
> >         good enough for a broad audience. People will just switch to
> >         another one
> >         rather than reporting and causing even the most simple bugs to
> >         get
> > 
> > you are afraid nobody is going to use uswsusp (because it doesn't work
> > or is not useful) and not going to report any bugs against it, and it
> > will cease to exist over time. I think that is very good. Survival of
> > the good. The winner will be decided by users automatically. Not by
> > someone who 
> 
> 
> note that I'm not picking sides. I don't care which ego gets to win.
> What do care about that Linux ends up with a good implementation,
> whatever that is. I have no idea is uswsusp will make it (in fact it
> feels fragile to me, but then again all sw suspend implementations
> including swsusp2 feel fragile to me). But for crying out loud
> 
> PICK ONE AND MAKE IT GOOD.
> 
> Bang heads together. Go for beer at OLS. I don't care how, but anything
> to prevent the insane thing of having multiple half working
> implementations.

I think everyone agrees with that.  However, the problem is we already have
two of them and one is out of the tree.  Each of them has its supporters who
believe their implementation of choice is "better" and want it to become
the Only One.  Unfortunately the implementations are not 100% mergeable for
technical reasons and the out-of-the-tree one is more feature-rich.

Now there seem to be two possible ways to go:
1) Drop the implementation that already is in the kernel and replace it with
the out-of-the-tree one.
2) Improve the one that already is in the kernel incrementally, possibly
merging some code from the out-of-the-tree implementation, so that it's as
feature-rich as the other one.

Apparently 1) is what Nigel is trying to make happen and 2) is what I'd like
to do.

Greetings,
Rafael
