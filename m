Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266061AbUAFDJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUAFDJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:09:00 -0500
Received: from linuxfools.org ([216.107.2.99]:14288 "EHLO loki.linuxfools.net")
	by vger.kernel.org with ESMTP id S266061AbUAFDIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:08:20 -0500
Date: Mon, 5 Jan 2004 22:24:57 -0500 (EST)
From: Jonathan Higdon <jhigdon@linuxfools.org>
To: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Bastiaan Spandaw <lkml@becobaf.com>,
       Tomas Szepe <szepe@pinerecords.com>, Max Valdez <maxvalde@fis.unam.mx>
Subject: Re: 2.6.1-rc1 affected?
In-Reply-To: <20040106024723.4579.qmail@web40605.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0401052222070.746@loki.linuxfools.org>
References: <20040106024723.4579.qmail@web40605.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, [iso-8859-1] szonyi calin wrote:

>  --- Jesper Juhl <juhl-lkml@dif.dk> a écrit : >
> > On Tue, 6 Jan 2004, Max Valdez wrote:
> >
> > > At least it hangs a redhat 7.2 kernel
> > >
> > > I will test it further tomorrow, but it looks like a good
> > proof to me
> > >
> > > > >
> > > > > > There _is_ an exploit:
> > > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> > > > > > "Since no special privileges are required to use the
> > mremap(2)
> > > system
> > > > > ...
> > > > >
> > > > > I will not believe the claim until I've seen the code.
> > > >
> > > > Not sure if this works or not.
> > > > According to a slashdot comment this is proof of concept
> > code.
> > > >
> > > > http://linuxfromscratch.org/~devine/mremap_poc.c
> > > >
> > > > Regards,
> > > >
> > > > Bastiaan
> > > >
> >
> > On my box that program is a very effective 'instant reboot'.
> >
>
> on mine just a segfault :-)
> sony@grinch -04:47:32- 0 jobs, ver 2.05b.0 3
>  /~/schule $ gcc -o mremap_poc mremap_poc.c
> sony@grinch -04:47:35- 0 jobs, ver 2.05b.0 3
>  /~/schule $ ./mremap_poc
> Segmentation fault
>
> > The instant I ran it from a xterm my screen went black, the
> > music I was
> > listening to from a CD stopped and the machine rebooted.
> > The running kernel was 2.6.1-rc1-mm1
> >
>
> maybe you were running the program as root ?

I tried it on 2.6.0 as a regular user and got an instant reboot.
stracing it showed the faults and the system was unusable after that :)

~jon
