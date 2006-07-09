Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWGITLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWGITLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWGITLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:11:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40719 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161060AbWGITLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:11:09 -0400
Date: Sun, 9 Jul 2006 21:11:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
Message-ID: <20060709191107.GN13938@stusta.de>
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com> <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com> <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com> <20060709125805.GF13938@stusta.de> <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:46:28PM -0400, Daniel Bonekeeper wrote:
> >I'm sorry for being so negative, but it seems you are overdesigning a
> >solution for a non-existing problem:
> >
> >There are cases where the machine is simply dead with exactly zero
> >information. These are the really hard ones.
> 
> Then really there isn't anything that we can do, except to expect the
> kindness of the user in taking a picture of his screen and posting on
> the kernel's bugzilla.

No, I'm talking about freezes without anything printed.

As soon as anything is printed, it becomes easier.

> >Then there are cases where the kernel is able to print a BUG() or Oops
> >to a log file. Or the error message is printed to the screen and the
> >user uses a digital camera and sends the photo.
> 
> Then again, users may just continue using the machine (without even
> noticing the Oops), or notice but never care to report it, or forgets,
> etc.

If the user doesn't notice what is written into his logs, the solution 
is to change this (e.g. via logcheck).

And if the user doesn't care, there's no reason for getting the bug 
report - a bug report from a not responsive user is worse than no bug 
report.

> >The message is usually enough for starting to debug the problem or
> >asking the user for additional information.
> >
> >But most important, the problem lies in a completely different area:
> >
> >Interaction between kernel devlopers and users is not a real problem.
> >The real problem is the missing developer manpower for handling bug
> >reports.
> 
> Well Adrian, this is the other side of the problem. We don't actually
> need a kernel monkey to keep looking for bugs that comes (even thought
> would be good, but as you stated, there is not enough manpower to do
> that), even more after having something that automatically sends Oops
> reports to the server, where we could expect thousands of bug reports
> daily... but I also believe that not having somebody to look at them
> is not an excuse for not having this bug taken account for. For
>...
> In resume, don't being able to investigate each report isn't a reason
> for not being acknowledged of its existance, and even we don't
> investigate it, having it for statistical purposes is already a great
> deal.

I'm still sure the important points are
- developer manpower and
- responsive bug submitters,
and your proposal doesn't help with any of these.

But this is open source, so feel free to send a patch implementing your 
ideas and prove me wrong.

> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

