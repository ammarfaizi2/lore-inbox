Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275735AbRI0CUH>; Wed, 26 Sep 2001 22:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275736AbRI0CT6>; Wed, 26 Sep 2001 22:19:58 -0400
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:18560 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S275735AbRI0CTn>; Wed, 26 Sep 2001 22:19:43 -0400
Message-Id: <200109270219.f8R2Jxn03458@foo-bar-baz.cc.vt.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview 
In-Reply-To: Your message of "Thu, 27 Sep 2001 00:14:33 BST."
             <E15mNsv-0002Cv-00@the-village.bc.nu> 
From: Valdis.Kletnieks@vt.edu
X-URL: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
In-Reply-To: <E15mNsv-0002Cv-00@the-village.bc.nu>
Date: Wed, 26 Sep 2001 22:19:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001 00:14:33 BST, Alan Cox said:
> > I'm really trying to be constructive here.  There is a real licensing 
> > problem over whether binary modules are legitimate at all, and the issue 
> > is not special to LSM. I'm trying to get LSM out of the way so that the 
> > advocates of either side can fight it out without smushing LSM in the 
> > middle :-)
> 
> Yes - I agree. The question is "can you be using the LSM module" not
> the headers - since LSM is GPL and your work relies on it 

Unfortunately, the commentary in /usr/src/linux/COPYING exempting programs
that use the syscall interface is clear as mud.

I can read it as saying "the syscall interface is hereby granted an exemption,
and other normal uses of the kernel are specifically NOT exempted".  In that
case, all authors of closed-source loadable modules are heretics and need to
be burnt at the stake. ;)

I can equally easily read it as "normal use of the kernel does not fall
under 'derivative work', and the syscall inferface is cited as one example
of normal use".  Given that Linus has been quoted elsewhere as saying that
closed-source modules are not *inherently* evil, this may be the intended reading.

I can equally easily read it as "Linus wrote it when the syscall interface WAS
the only interface, and never updated it for loadable modules...." ;)

Personally, I'd not be at all surprised to find out that none of my 3 readings
are anywhere close to the actual meaning as decided by a court of law....

				Valdis Kletnieks
				Operating Systems Analyst
				Virginia Tech
