Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbRJKIvb>; Thu, 11 Oct 2001 04:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJKIvX>; Thu, 11 Oct 2001 04:51:23 -0400
Received: from zeus.eurotux.com ([194.38.142.74]:46486 "HELO zeus.eurotux.com")
	by vger.kernel.org with SMTP id <S274034AbRJKIum> convert rfc822-to-8bit;
	Thu, 11 Oct 2001 04:50:42 -0400
Message-ID: <3BC56B0B.92C0A31@eurotux.com>
Date: Thu, 11 Oct 2001 09:48:59 +0000
From: Ricardo Manuel Oliveira <rmo@eurotux.com>
Organization: Eurotux =?iso-8859-1?Q?Inform=E1tica?=, SA
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel 82815 VGA
In-Reply-To: <E15kPHi-0008Ev-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >  Problem with i815EM chipset (in ASUS M1000 laptop series) -
> > the display blinks *VERY* frequently - seems to blink for
> > every disk access or so.
> 
> It shouldnt be affected by PCI traffic but I guess its possible someone
> has been sawing bits off. Try turning off ide DMA

 I keep getting emails from people which have seen my post.
To all of them (and everyone else):

 There's an undocumented bit in an undocumented register in
the built-in graphics device of Intel's i810 (i815?) chipset
(GMCH).  Setting that bit to a 1 solved out this problem
(which someone affectuously called 'the damn blinking
problem').

 Get the code at http://www.cl.cam.ac.uk/~pb/wmi810.tar.gz ,
compile, install, read the README/INSTALL. It's as simple as
that.


 To everyone who has tried to help in this mailing list, my
apollogies. This should be fixed in the XFree driver (I hope
it'll be fixed in the next release). Also, my thanks to
every single one who tried to help.


----
Ricardo Manuel Oliveira
Eurotux Informática, SA
Tel: +351 253257395 // +351 919475934
Fax: +351 253257396
