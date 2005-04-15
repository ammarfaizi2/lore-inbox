Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVDOTmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVDOTmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVDOTmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:42:04 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:37915 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261941AbVDOTlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:41:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aHhh9ZpS9cg2QXj0hpjiHhK0qTpWll/lxObNBvUl5A47213XhAId/Ye/Fvb9Y3/48wV8Ihhx6Yoxd0/6E5bV8ejNFVWHQvRTO1G/8YHEU+KnUzSiYhocRfWMkfC+LAmbeOKScmR/JbeZmtoaYt+tnioO1qNKmJztPipHDa6qXFY=
Message-ID: <6533c1c905041512411ec2a8db@mail.gmail.com>
Date: Fri, 15 Apr 2005 15:41:34 -0400
From: Igor Shmukler <igor.shmukler@gmail.com>
Reply-To: Igor Shmukler <igor.shmukler@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: intercepting syscalls
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1113588694.6694.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks to everyone for replying.
It is surprising to me that linux-kernel people decided to disallow
interception of system calls.
I don't really see any upside to this.
I guess if there is no clean way to do this, we will have to resort to
quick and dirty.

Can anyone point to a discussion that yielded this decision. Perhaps,
I need to educate myself. I stumbled upon comments that this can lead
to mess, but pretty much anything in LKM can cause problems. I don't
think that hiding commonly used convenient interfaces just because
they can be abused is a valid reason, hence I would love to know what
is the real reason.

Thank you,

Igor


On 4/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2005-04-15 at 14:04 -0400, Igor Shmukler wrote:
> > Hello,
> > We are working on a LKM for the 2.6 kernel.
> > We HAVE to intercept system calls. I understand this could be
> > something developers are no encouraged to do these days, but we need
> > this.
> 
> your module is GPL licensed right ? (You're depending on deep internals
> after all)
> 
> Why do you *have* to intercept system calls... can't you instead use the
> audit infrastructure to get that information ?
> 
> What is the URL of your current code so that we can provide reasonable
> recommendations ?
