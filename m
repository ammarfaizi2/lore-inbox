Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281462AbRKMEPl>; Mon, 12 Nov 2001 23:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKMEPb>; Mon, 12 Nov 2001 23:15:31 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:38284 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281462AbRKMEPV>; Mon, 12 Nov 2001 23:15:21 -0500
Message-ID: <3BF09E44.58D138A6@mandrakesoft.com>
Date: Mon, 12 Nov 2001 23:15:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
		<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu> <200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Alexander Viro writes:
> > On Mon, 12 Nov 2001, Richard Gooch wrote:
> > > Dave Jones writes:
> > > > How about running mtrr.c & devfs code through scripts/Lindent
> > > > sometime btw?

Go ahead and Lindent mtrr.c, it hasn't been touched by rgooch in a
while...


> > > That would be a step backwards: I wouldn't be able to read my own code
> > > then.
> >
> > You mean that you are unable to read any of the core kernel source?
> > That would explain a lot...
> 
> Were you born rude, or did you have to practice it?

I would argue both ;-)  He is a Usenet denizen after all.
(takes one to know one... I'm one as well :))

He and davej still have a point.  Your code formatting is non-standard,
and is difficult to read.  A document exists CodingStyle which explains
a good style, and further -why- it is a good style.

Among other reasons, because of long term maintenance.

How do you expect others in the Linux kernel community to review your
code, if it is widely considered difficult to read?  How do you expect
people to maintain your code when are no longer around?  The Linux
kernel will be around long after you and I and others leave kernel
development.  Others need to read and maintain this code.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

