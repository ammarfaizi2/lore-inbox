Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316247AbSEQOkn>; Fri, 17 May 2002 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSEQOjw>; Fri, 17 May 2002 10:39:52 -0400
Received: from 209-6-202-152.c3-0.nwt-ubr1.sbo-nwt.ma.cable.rcn.com ([209.6.202.152]:58866
	"EHLO chezrutt.dyndns.org") by vger.kernel.org with ESMTP
	id <S316247AbSEQOjm>; Fri, 17 May 2002 10:39:42 -0400
From: John Ruttenberg <rutt@chezrutt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15589.5673.460356.221529@localhost.localdomain>
Date: Fri, 17 May 2002 10:39:37 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Inspiron i8100 with 2 batteries
In-Reply-To: <E178j9U-0006fz-00@the-village.bc.nu>
X-Mailer: VM 6.96 under Emacs 20.7.1
Reply-to: rutt@chezrutt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd try to figure out that there were two batteries and divide by 2
or something like that.  Perhaps the bios of this notebook is just broken,
though.

Alan Cox:
> > of the batteries is less than 50% (according to the bios), then /proc/apm
> > shows the battery power level X 2.  If the combined charge of the batteries is
> > greater than 50%, then /proc/apm shows:
> > 
> >     1.16 1.2 0x03 0x01 0xff 0x10 -1% -1 ?
> > 
> > I think this is because the bogus calculation it would make would result in a
> > percentage > 100.
> > 
> > I took a quick look at arch/i386/kernel/apm.c but it wasn't obvious what to
> > do.
> 
> The data basically comes from the BIOS as is



