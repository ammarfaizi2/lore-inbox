Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSEEX7j>; Sun, 5 May 2002 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313907AbSEEX7i>; Sun, 5 May 2002 19:59:38 -0400
Received: from relay1.pair.com ([209.68.1.20]:29458 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S313906AbSEEX7h>;
	Sun, 5 May 2002 19:59:37 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD5C816.D73F0532@kegel.com>
Date: Sun, 05 May 2002 17:02:30 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <8473.1020642293@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 05 May 2002 09:42:35 -0700,
> Dan Kegel <dank@kegel.com> wrote:
> >Keith also says:
> >> I am temporarily omitting [modversions] which is (a) currently broken
> >> (b) is not being used in development kernels and (c) cannot be fixed
> >> without a radical redesign.  Modversions is not needed right now and
> >> will be added later.  Everything I have done in kbuild 2.5 is needed
> >> now
> >
> >[Caveat: I'm not much of a kernel hacker.]
> >My only concern with kbuild 2.5 was the lack of modversions,
> >but since Richard is promising to add them in before the
> >distros need them,
> 
> You misquoted.  Richard is not promising to add modversions, I am.
> I maintain both kbuild and modutils, the two halves of the modversion
> problem.

Sorry, that was a fingerslip.  I meant to say Keith.

BTW I'm looking at your kbuild 2.5 performance measurements at
http://www.mail-archive.com/kbuild-devel%40lists.sourceforge.net/msg01434.html
Looks like 9 seconds to rebuild the kernel after a small change
on a quad 700MHz pentium, right?   (Or does 'make phase4' not actually build?)
What would the time be on a dual pentium?
- Dan
