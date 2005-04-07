Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVDGRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVDGRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVDGRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:52:25 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:58147 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262535AbVDGRwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:52:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=N9BVN8NeK+nxO8QISX2LciDwrQnFxAEyipAn8vQmWwm+asCFNcDS754QeBj5jMH4blaWMc8PwjHutisJw59nKlsdeXsoSxqDVKJx0dMb9/5J2gxJhMM2JbixGQE5RqXybkKj/8mgyt+1mT/FDPUbFnc+v1AUiXFbc2Z8+vex0kI=
Message-ID: <58cb370e05040710526bab8ce7@mail.gmail.com>
Date: Thu, 7 Apr 2005 19:52:06 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Kernel SCM saga..
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <1112858331.6924.17.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
	 <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 7:10 PM, Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> On Thu, Apr 07, 2005 at 08:32:04AM -0700, Linus Torvalds wrote:
> > Also, there's actually a second reason why I've decided that cherry-
> > picking is wrong, and it's non-technical.
> >
> > The thing is, cherry-picking very much implies that the people "up" the
> > foodchain end up editing the work of the people "below" them. The whole
> > reason you want cherry-picking is that you want to fix up somebody elses
> > mistakes, ie something you disagree with.
> 
> No.  There's another reason - when you are cherry-picking and reordering
> *your* *own* *patches*.  That's what I had been unable to explain to
> Larry and that's what made BK unusable for me.

Yep, I missed this in BK a lot.

There is another situation in which cherry-picking is very useful:
even if you have a clean tree it still may contain bugfixes mixed with
unrelated cleanups and sometimes you want to only apply bugfixes.

Bartlomiej
