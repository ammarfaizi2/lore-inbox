Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRACMKw>; Wed, 3 Jan 2001 07:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130812AbRACMKm>; Wed, 3 Jan 2001 07:10:42 -0500
Received: from p3EE3CA16.dip.t-dialin.net ([62.227.202.22]:38660 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S130325AbRACMKd>; Wed, 3 Jan 2001 07:10:33 -0500
Date: Wed, 3 Jan 2001 12:40:05 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.24 is available
Message-ID: <20010103124005.A5179@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010102191249.A4299@emma1.emma.line.org> <9779.978505495@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9779.978505495@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, Jan 03, 2001 at 18:04:55 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2001, Keith Owens wrote:

> Matthias Andree <matthias.andree@stud.uni-dortmund.de> wrote:
> >There's a problem. depmod should not try to do anything besides giving
> >its version when --version is used, should it?
> 
> Historical accident.  I want to clean that up but it breaks existing
> behaviour; somewhere, somebody is bound to rely on depmod -V updating
> modules.dep at the same time.  modutils 2.5 will clean up a lot of
> backwards compatibility crud, including this one.  But you will not see
> modutils 2.5 until Linus rolls kernel 2.5 and we start the next
> development cycle.

Okay, backwards compatibility weighs a lot.

May I kindly ask you to give a note that -V does NOT terminate the
program, but also comprises regular operation in --help and the man
pages? 

I can send in a patch if you want (that just changes the docs, but not
the functionality).

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
