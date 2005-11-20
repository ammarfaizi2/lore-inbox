Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVKTBp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVKTBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVKTBp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:45:28 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:40350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751134AbVKTBp2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:45:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yn/sEjqK5W1UfnZPeF8kTdETBzF7QsPbxpRYBPn8pbEqCVJfobPUIMktTWb1Io4OqXGQysC0SpAP1fvpdwoXenEa6U8XuqowUbIMOIhnfCIOzWNPO7HvJbCyE7ovBBPRaUnRbmOuisZqS6b2/N2hfI7YWdkE6jRhiRXpbbUkrDQ=
Message-ID: <9a8748490511191745h6aebd102r91007bc2b84382ff@mail.gmail.com>
Date: Sun, 20 Nov 2005 02:45:27 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20051119173358.2bf1dbb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511200010.33658.jesper.juhl@gmail.com>
	 <20051119162805.47796de9.akpm@osdl.org>
	 <9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
	 <20051119170818.5e16afae.akpm@osdl.org>
	 <9a8748490511191715x61057bc8i1431ca3a24cfb2e6@mail.gmail.com>
	 <20051119173358.2bf1dbb5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Ok, so does that mean that, if properly verified, patches for things
> >  that "gcc -Wsigned-compare" flags will be appreciated?
>
> All patches are appreciated, but not all are applied ;)
>
> Sure, go for it - let's see what the patches end up looking like.  We might
> find real bugs in there - I found a bunch of howlers back in 2.3.late.
> That was with `gcc -W' which turns on more than -Wsigned-compare.
>
> Maybe you could prepare a quick overall summary first, see if you can work
> out the overall scope of the problem and then we can take a look at that,
> decide what bits to attack?
>
Sure, I'll do that tomorrow.
All these sign issues all over annoy me :)
I'll try to get a handle on the scope of the thing tomorrow, then send
a mail with what I find, then we can talk about what would be useful
to do.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
