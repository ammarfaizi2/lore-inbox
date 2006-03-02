Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWCBUZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCBUZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWCBUZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:25:09 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:42283 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751095AbWCBUZH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:25:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PccWvbJ0mDUW7F/bz+oZ5JrSeeyFE2MSlF0AijrS6veWTDwEWub9gZ4V/pQuuEswFE+N8IgWgg+GPoO7LxAIei9k2SmBEufL93GAilNKd0KoJ9IdvTnPlulnLvtej+hwgkxcsOpT03zevB6y3hX/xGj9dC6sIUIqOUnruCCCivg=
Message-ID: <9a8748490603021225s570bbaa4xc260061398eeea7e@mail.gmail.com>
Date: Thu, 2 Mar 2006 21:25:06 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060226224300.GA8835@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <20060226224300.GA8835@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Feb 26, 2006 at 05:21:17PM +0100, Jesper Juhl wrote:
> >
> > Hi everyone,
> >
> > I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
> >
> >       95 kernels were build with 'make randconfig'.
> >       1 kernel was build with the config I normally use for my own box.
> >       1 kernel was build from 'make defconfig'.
> >       1 kernel was build from 'make allmodconfig'.
> >       1 kernel was build from 'make allnoconfig'.
> >       1 kernel was build from 'make allyesconfig'.
> >
> > That was an interresting experience.
> >
> > First of all not very many of the kernels actually build correctly and
> > secondly, if I grep the build logs for warnings I'm swamped.
> >
> > Out of 100 kernels 82 failed to build - that's an 18% success rate people,
> > not very impressive.
> I would recommed to fix the obvious cases and leave it.
> Better to concentrate on 'normal' configs. This includes
> allmodconfig/allyesconfig/defconfig but it certainly does not include a
> bunch of random configs. Real peoples config is much better for this.
>
Thank you for your input.

I agree that "common configs" are the most important ones, but I also
feel that problems need to be fixed in general no matter how "corner
case" or "trivial" or "uncommon" they may be.

I ran an experiment, I reported the results. And from the comments in
this thread and what I've also recieved privately I think I achieved
my goal of getting more bugs fixed :)
I personally fixed some of the warnings.
Other people fixed other warnings and errors as a result of my post.
People got thinking about these things.

All in all I think that's a good result :-)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
