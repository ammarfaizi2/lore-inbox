Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278759AbRJVMhJ>; Mon, 22 Oct 2001 08:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278778AbRJVMhA>; Mon, 22 Oct 2001 08:37:00 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:22288 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278759AbRJVMgv>;
	Mon, 22 Oct 2001 08:36:51 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: Your message of "Mon, 22 Oct 2001 08:15:45 -0400."
             <Pine.GSO.4.21.0110220811210.2294-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 22:37:13 +1000
Message-ID: <26403.1003754233@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 08:15:45 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Mon, 22 Oct 2001, Keith Owens wrote:
>
>> Please, no more 2.4 changes.  Let Linus get 2.4 stable, fork 2.5 so we
>> can break it on a daily basis then backport to 2.4 when it works.
>
>and
>
>> -ac kernels?  And have that behaviour depending on which version of
>> modutils the user installed?  Not in 2.4, modutils strives for
>> stability in production kernels, it is an important interface between
>> the kernel and user space.
> 
>Correct me if I'm wrong, but two quotes above seem to contradict each other
>- AFAICS arguments in the latter apply to backporting...

I left out a phrase.  "backport to 2.4 when it works and does not
affect 2.4 compatibility".  That is a given on modutils, I won't
consider anything that breaks modutils compatibility on any kernel from
2.4 right down to 2.0.  modutils 2.5 can shatter into tiny pieces, not
a problem.

