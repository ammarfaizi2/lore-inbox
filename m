Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVINXUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVINXUi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVINXUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:20:38 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:47603 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965105AbVINXUh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:20:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPy2hOvLa99msNAqvCRAD35CS+6hxgOXLrPFeS2O1AYmboo54quKcydOn9zH1SJVUTjcvK2MVZ9sbc2WjMg/HkvJTf6nqjLVeq5ESzALCkNYlXfOYZl3DZhn9fVDCTzd/Y1F0iIMdD27Mw0CwiTwJvdl6iQev2GTmQhlpbavjZ4=
Message-ID: <9a874849050914162069c0296f@mail.gmail.com>
Date: Thu, 15 Sep 2005 01:20:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Henrik Persson <root@fulhack.info>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43289A7E.1080307@fulhack.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <43289A7E.1080307@fulhack.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Henrik Persson <root@fulhack.info> wrote:
> Linus Torvalds wrote:
> > Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13,
> > and that means that the merge window is closed. I've released a
> > 2.6.14-rc1, and we're now all supposed to help just clean up and fix
> > everything, and aim for a really solid 2.6.14 release.
> 
> My cardbus is acting funny. When I insert my netgear wg511 (prism54) the
> first time after booting 2.6.14-rc1 nothing happens. Nothing in dmesg,
> nothing nowhere. I remove it. Still nothing. Oh well. Inserting again.
> THEN it initializes and is working like it usually does.
> 
> 2.6.13+Ivan's PCI resource patch worked allright.
> 
> I can live with this, but this is a regression.. I remember having
> exactly the same problem with some 2.4 kernel a few years back..
> 
> Any patch I should try backing out? Or some patch I should try?
> 
Somebody who's familliar with the code (as opposed to me) might be
able to point to a specific patch, but you could also try doing a
bisection search with  git bisect  to try and find the patch between
2.6.13 and 2.6.14-rc1 that broke it for you. A few handfuls of kernel
compiles/boots usually does the trick.
Search the archives for details, it's been described numerous times.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
