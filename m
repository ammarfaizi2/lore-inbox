Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269891AbUJSWFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269891AbUJSWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUJSV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:59:11 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:30059 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269926AbUJSVyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:54:17 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KtSwscI4PCsh7WBPkVlGnBeyoNX9tnWZ8YId8RZ1UbyAi9YJlyW41d884KMUjmwbUbQHtxB6J0NM4jqulXX02lus1/CTp3QXXuizv/XLa8nmy6r1tUITUUuqLZzXEaOgX6m0jK+ElRZsOOEj0rv085vQ2tSiN79IsSZ3yw1cJfc
Message-ID: <4d8e3fd3041019145469f03527@mail.gmail.com>
Date: Tue, 19 Oct 2004 23:54:16 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BK kernel workflow
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>,
       torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <20041019213803.GA6994@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41752E53.8060103@pobox.com>
	 <20041019153126.GG18939@work.bitmover.com>
	 <41753B99.5090003@pobox.com>
	 <4d8e3fd304101914332979f86a@mail.gmail.com>
	 <20041019213803.GA6994@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 17:38:03 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> On Tue, Oct 19, 2004 at 11:33:40PM +0200, Paolo Ciarrocchi wrote:
> > On Tue, 19 Oct 2004 12:06:49 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > > Although tangential to the problem, I thought LKML and BitMover (and
> > > maybe Andrew or Linus as well) might be interested in a general
> > > description of my workflow.
> > >
> > > For net drivers in the Linux kernel, there exists two patch queues,
> > > net-drivers-2.6 and netdev-2.6 (and corresponding 2.4 versions).
> > > net-drivers-2.6 could be described as the "upstream immediately" or "for
> > > Linus" queue, and netdev-2.6 could be described as the "testing" queue.
> >
> > So you have two bk trees,
> > - patches good for mainstream
> > - patches good for -mm tree
> 
> Close:
> - patches ready for mainstream
> - patches eventually ready for mainstream
> 
> and changes flow "up" from netdev-2.6 to net-drivers-2.6.

Yup, I hope that almost all the patches move from "patches eventually
ready for mainstream" to "patches ready for mainstream" ;-)

> 
> > It would be cool if all the maintainers could adopt your working method,
> > Andrew is already automatically pulling from a bunch of trees, why not
> > having Linusdoing the same too?
> 
> That's what Linus does already, when I email him :)

Good ;) but AFAIK Andrew is not publishing the "patches ready for
mainstream" (bk or collection of patches) tree.


> But Linus is essentially "senior editor", so we don't want to automate
> the system, otherwise there is no editorial control.  He is our
> emporer penguin, after all.

I understand, 
I know I'm pedantic but can we all see the list of bk trees ("patches
ready for mainstream" and "patches eventually ready for mainstream")
that we'll be used by Linus ?

I'm learning a lot trying to understand the development method used by
this community,
but there are things that I don't fully understand, 
is it possible to "formalize" it (somehow) ?

Ciao and thanks!

-- 
Paolo
Personal home page: www.ciarrocchi.tk
