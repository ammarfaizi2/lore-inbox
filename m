Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSJTKZe>; Sun, 20 Oct 2002 06:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263356AbSJTKZe>; Sun, 20 Oct 2002 06:25:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52233 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263279AbSJTKZd>; Sun, 20 Oct 2002 06:25:33 -0400
Date: Sun, 20 Oct 2002 11:31:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LARGE patch 23/124] sets sent over and over again Re: [PATCH] ext2/3 updates for 2.5.44 (1/11): Default mount options in superblock
Message-ID: <20021020113135.A25278@flint.arm.linux.org.uk>
References: <E183CUa-0007Yq-00@snap.thunk.org> <1035108575.3130.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035108575.3130.10.camel@localhost.localdomain>; from arjanv@redhat.com on Sun, Oct 20, 2002 at 12:09:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 12:09:35PM +0200, Arjan van de Ven wrote:
> I hereby politely ask EVERYONE who wants to (re)posts large patchsets,
> to at minimum try to follow something like the following politeness
> guidelines
> 
> 1) Make it ONE thread. Do this by cc or bcc'ing yourself on the mails
>    and use the reply feature of your mailer to reply each next number of
>    the set to the previous one. This allows people that use mail/news
>    readers that can do threading to properly sort it. This is not hard,
>    and I consider it the least you can do for the people that read lklm.

It would be nice if someone scripted this - then people will be much more
likely to follow it.  It should be relatively trivial to script; you
just need to generate the message id's and add the relevant headers.

I'd like to question the appropriateness of such a blanket rule.  I agree
that it is appropriate for patches that are all part of the same area of
the kernel (eg, ext2fs, ext3fs, trace toolkits, etc)

However, is it appropriate to make one thread of a small set of unrelated
patches that touch different, unrelated parts of the kernel?

If all you want to do is delete them, I agree it does.  However, that
doesn't help the sender, who's reason for sending them is to get comments
from the community.

For instance, one of my patches - the rdunzip one.  It would be _really_
nice to get some feedback on it; it isn't perfect, because the behaviour
of gunzip is inherently undeterministic when given bad input data.  The
only real solution IMHO is setjmp/longjmp, which I think would suck in
the kernel.  I would have expected _this_ to attract some comments from
people like you.  Maybe you feel that setjmp/longjmp is an approprate
solution.  Unfortunately, I don't know that because no one has replied
to tell me so.

Maybe very few people look at them, I don't know.  If that is the case,
I might as well send them directly to Linus and bypass lkml altogether.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

