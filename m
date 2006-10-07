Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932846AbWJGVCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbWJGVCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 17:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbWJGVCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 17:02:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:52848 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932846AbWJGVCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 17:02:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NKfgaXrWYg4+BR95ULv8XDjcz45CyfErdOmErqOP6QH5ctOP/Aljvf+3puo/kRwK7HoViHp0q+Tv2Uen277ihb54BMERtji51bz5OsZYm62DReF4yLzi6HaBO1bhacVBi63I47BImAGz6/Q67UcCeiVram7V9B//Hxb1ur1hMOQ=
Message-ID: <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
Date: Sat, 7 Oct 2006 23:02:43 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sat, 7 Oct 2006, Jesper Juhl wrote:
> >
> > Which has worked great in the past, but with recent kernels it has
> > been a sure way to cause a complete lockup within 1 hour :-(
>
> Reliable lock-ups (and "within 1 hour" is quite quick too) are actually
> great.
>
> > 2.6.17.13 .
> > The first kernel where I know for sure it caused lockups is
> > 2.6.18-git15 .   I've also tested 2.6.18-git16, 2.6.18-git21 and
> > 2.6.19-rc1-git2 and those 3 also lock up solid.
>
> Can I bother you to just bisect it?
>
Sure, but it will take a little while since building + booting +
starting the test + waiting for the lockup takes a fair bit of time
for each kernel and also due to the fact that my git skills are pretty
limited, but I'll figure it out (need to improve those git skills
anyway) :-)

I'll be back with more info.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
