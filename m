Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUAFDvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUAFDvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:51:16 -0500
Received: from web40609.mail.yahoo.com ([66.218.78.146]:20117 "HELO
	web40609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265331AbUAFDvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:51:14 -0500
Message-ID: <20040106035114.63926.qmail@web40609.mail.yahoo.com>
Date: Tue, 6 Jan 2004 04:51:14 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: 2.6.1-rc1 affected?
To: Jonathan Higdon <jhigdon@linuxfools.org>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>,
       Bastiaan Spandaw <lkml@becobaf.com>,
       Tomas Szepe <szepe@pinerecords.com>, Max Valdez <maxvalde@fis.unam.mx>
In-Reply-To: <Pine.LNX.4.58.0401052222070.746@loki.linuxfools.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Jonathan Higdon <jhigdon@linuxfools.org> a écrit : > 
> 
> On Tue, 6 Jan 2004, [iso-8859-1] szonyi calin wrote:
> 
> > >
> > > On my box that program is a very effective 'instant
> reboot'.
> > >
> >
> > on mine just a segfault :-)
> > sony@grinch -04:47:32- 0 jobs, ver 2.05b.0 3
> >  /~/schule $ gcc -o mremap_poc mremap_poc.c
> > sony@grinch -04:47:35- 0 jobs, ver 2.05b.0 3
> >  /~/schule $ ./mremap_poc
> > Segmentation fault
> >

correction
if it is compileg withj -g and statically linked and run from
a gdb session it hard locks the machine. Only a hard reset helps
if it's run from a shell -> segfaults :-)
so at least on my system an atacker needs gdb to crash the 
machine :-)
 

> > > The instant I ran it from a xterm my screen went black,
> the
> > > music I was
> > > listening to from a CD stopped and the machine rebooted.
> > > The running kernel was 2.6.1-rc1-mm1
> > >
> >
> > maybe you were running the program as root ?
> 
> I tried it on 2.6.0 as a regular user and got an instant
> reboot.
> stracing it showed the faults and the system was unusable
> after that :)
> 
> ~jon

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

_________________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
