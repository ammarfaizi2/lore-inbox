Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSC3KfU>; Sat, 30 Mar 2002 05:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312444AbSC3KfL>; Sat, 30 Mar 2002 05:35:11 -0500
Received: from p50847E38.dip.t-dialin.net ([80.132.126.56]:29664 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S312384AbSC3Key>;
	Sat, 30 Mar 2002 05:34:54 -0500
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
	<linux-ntfs-dev@lists.sourceforge.net>,
        Padraig Brady <padraig@antefacto.com>
Subject: Re: Re[2]: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <Pine.SOL.3.96.1020329124320.18653A-100000@virgo.cus.cam.ac.uk>
	<ISPFE11QlZFJyUpZ7Nq000037fb@mail.takas.lt>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Sat, 30 Mar 2002 11:34:47 +0100
Message-ID: <m3vgbetkc8.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas <nerijus@users.sourceforge.net> writes:

> On Fri, 29 Mar 2002 12:57:07 +0000 (GMT) Anton Altaparmakov <aia21@cus.cam.ac.uk> wrote:
>
> [...] Discussion about default fmask, mc, being able to run in place
>       snipped
>
> People using Linux usually keep data files on fat and ntfs permissions, not
> executables (IMHO).

For the sake of another vote: Yes, I do use NTFS primarily for data
storage, and No, I don't like gratuitous x-bits. Not *at all*. Not
because I work with some specific software that should be "fixed", but
because I think it is quite b0rken to flag "executable" in the general
case.

What I would like to see (probably exists somewhere) is a (userland)
tool which can fire up an exec image residing in a readable (not
executable) file - that would take care of the "star office
installation" case, as well. If said tool was called "run" it would
have all semantics intuitively expected by me.

But even without "run" I'd be very much happier with x off by default
- those who want it should turn it on using mount -o fmask, not the
other way around.


Just my opinion.


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
