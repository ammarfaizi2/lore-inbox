Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277355AbRJJSTD>; Wed, 10 Oct 2001 14:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277354AbRJJSSx>; Wed, 10 Oct 2001 14:18:53 -0400
Received: from t2.redhat.com ([199.183.24.243]:47351 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277352AbRJJSSs>; Wed, 10 Oct 2001 14:18:48 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15rNBu-0008To-00@the-village.bc.nu> 
In-Reply-To: <E15rNBu-0008To-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro), kaos@ocs.com.au (Keith Owens),
        sirmorcant@morcant.org (Morgan Collins [Ax0n]),
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 19:18:30 +0100
Message-ID: <4058.1002737910@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Subject to patent holdings. If you hold a patent on the BSD code you
> can't GPL it

That's not wonderfully clear. They don't have to _restrict_ your rights -
just neglect to grant you the right to use the algorithm in question, which
you didn't have in the first place anyway.

> nor is it GPL compatible. 

I believe that statement is as true as the assertion that nobody, even in
the Free World, can write GPL'd code which use the algorithms covered by 
the patent.

Either way, I didn't think that a political stance against patents was the 
point of the kernel tainting code - I thought it was about maintainability.

>  The problem we have is that "BSD without advertisment" can be claimed
> by almost any binary only module whose author doesnt include source or
> let it out fo their company ever 

GPL can also be claimed by a module whose author doesn't publish either the
source or the binary, or who charges lots and lots of money for shipping the
binary and ships the source with it with a 'request' that the recipient
doesn't then give it away for free.

But if we're not going to allow BSD-licensed modules to be loaded without 
tainting the kernel, we shouldn't mark any of the code distributed with the 
kernel as BSD-licensed - we should make it all "Dual BSD/GPL" instead.

It might also be useful to have a 'Dual GPL/Other' option, for covering the 
other randomly dual-licensed code (like JFFS2). 

--
dwmw2


