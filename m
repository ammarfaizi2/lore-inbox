Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUAFCr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUAFCr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:47:26 -0500
Received: from web40605.mail.yahoo.com ([66.218.78.142]:14637 "HELO
	web40605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265273AbUAFCrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:47:24 -0500
Message-ID: <20040106024723.4579.qmail@web40605.mail.yahoo.com>
Date: Tue, 6 Jan 2004 03:47:23 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: 2.6.1-rc1 affected?
To: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Cc: Bastiaan Spandaw <lkml@becobaf.com>, Tomas Szepe <szepe@pinerecords.com>,
       Max Valdez <maxvalde@fis.unam.mx>
In-Reply-To: <Pine.LNX.4.56.0401060221170.7597@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Jesper Juhl <juhl-lkml@dif.dk> a écrit : > 
> On Tue, 6 Jan 2004, Max Valdez wrote:
> 
> > At least it hangs a redhat 7.2 kernel
> >
> > I will test it further tomorrow, but it looks like a good
> proof to me
> >
> > > >
> > > > > There _is_ an exploit:
> > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> > > > > "Since no special privileges are required to use the
> mremap(2)
> > system
> > > > ...
> > > >
> > > > I will not believe the claim until I've seen the code.
> > >
> > > Not sure if this works or not.
> > > According to a slashdot comment this is proof of concept
> code.
> > >
> > > http://linuxfromscratch.org/~devine/mremap_poc.c
> > >
> > > Regards,
> > >
> > > Bastiaan
> > >
> 
> On my box that program is a very effective 'instant reboot'.
> 

on mine just a segfault :-)
sony@grinch -04:47:32- 0 jobs, ver 2.05b.0 3 
 /~/schule $ gcc -o mremap_poc mremap_poc.c 
sony@grinch -04:47:35- 0 jobs, ver 2.05b.0 3 
 /~/schule $ ./mremap_poc 
Segmentation fault

> The instant I ran it from a xterm my screen went black, the
> music I was
> listening to from a CD stopped and the machine rebooted.
> The running kernel was 2.6.1-rc1-mm1
> 

maybe you were running the program as root ?

> 
> - Jesper Juhl
> 
> -

Calin

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

_________________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
