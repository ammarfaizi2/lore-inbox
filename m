Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVLUJRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVLUJRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVLUJRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:17:47 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:60991 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbVLUJRq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:17:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e/5vFExnDHoA5h2YuzRtcYuf73tFymFrCnT20uB0pKSc1Ec700DPsLFbiDpLGPhSfDZ+cDExvtnXaVEVO0zQeI3PMSa/kjcNorW2eoUSV5fPTzc+N8Ztcx6lSultq38JYSRLm37XtMZMo1EmB5JBTsAq5l3GrvvJjRwKt8CCdhA=
Message-ID: <9a8748490512210117h1f779e3cy3cd0973723e38b8d@mail.gmail.com>
Date: Wed, 21 Dec 2005 10:17:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Luke Yang <luke.adi@gmail.com>
Subject: Re: kernel development process questions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <489ecd0c0512202117q303ef7f1qae6bc08c9637be39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0512202117q303ef7f1qae6bc08c9637be39@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Luke Yang <luke.adi@gmail.com> wrote:
> Hi all,
>
>    Thanks for Greg's howto and others' documents (Such as the "kernel
> hacker's guide to git). But I still have some detail questions:
>
>    Which is everyone working on: the "latest linus git tree" or the
> "-mm kernel"?

I can't answer for anyone but myself, but I personally try to test
both and look for problems in both.
Most patches I submit are against the latest Linus git tree since
Andrew usually handles merging that into -mm just fine. If I'm working
on something that's currently only present in -mm (or radically
different in -mm), then latest -mm is what I work on.

So a little of both.


>As I tried, the -mm kernel is only a patch, which MAY
> can not be applied to latest kernel. For example, current
> 2.6.15-rc5-mm3 patch can't be applied to  current kernel without
> rejections and conflicts.
>
The 2.6.15-rc5-mm3 patch applies to 2.6.15-rc5 as its name implies.
Take a look at http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt


>    As Greg pointed out, most patches should be tested on -mm kernel.
> So I assum that a developer just get an exact 2.6.15-rc5 kernel from
> git, apply the 2.6.15-rc5-mm3 patch, do some work and send out the
> patch, then just stay there for next -mm patch?
>
Sure, that's one way to do it as well.


>    Thanks in advace!
>
> BTW:  git question, Is there any way to get my .git/refs/ folder
> updated through http? I mean not through rsync?
>
> Regards,
> Luke Yang
> Analog Device Inc.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
