Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312422AbSCURmQ>; Thu, 21 Mar 2002 12:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312428AbSCURmH>; Thu, 21 Mar 2002 12:42:07 -0500
Received: from Expansa.sns.it ([192.167.206.189]:8465 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312422AbSCURl5>;
	Thu, 21 Mar 2002 12:41:57 -0500
Date: Thu, 21 Mar 2002 18:41:49 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
cc: green@namesys.com
Subject: Re: oops at boot with 2.5.7 and i810 (reiserFS related?) 
Message-ID: <Pine.LNX.4.44.0203211841010.21275-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Maybe you are right.
I tested a 2.5 kernel with another server with scsi adaptec, and
it worked with ext2 but oops while mounting reiserFS.

It seems that a lot of users had oops mounting reiserFS with 2.5.6, but
then a patch fixed that. Now I think this patch is in 2.5.7, (it should),
but there are other changes i think to reiserFS code. So i have other
oopses.

I think this could be a proof of a reiserFS bug.

If people at namesys need it (maybe they already know this, and have a
patch to try), tomorrow i will post the oop mounting
reiserFS.

Luigi

On Wed, 20 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> > yes, as I said at the beginning
> >
>
> Ohhh... I did miss this apparently...
>
> OK. Anyway I'm quite confident that *this* particular
> flaw is nto caused by the ICH host chip code but by a dance between Hand and
> Alexander... instead.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


