Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVJYJyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVJYJyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVJYJyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 05:54:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25874 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932119AbVJYJyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 05:54:46 -0400
Date: Tue, 25 Oct 2005 11:54:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Badari Pulavarty <pbadari@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051025095441.GA5329@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130168434.6831.1.camel@localhost.localdomain> <20051024154342.GA24527@stusta.de> <1130174497.12873.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130174497.12873.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 06:21:37PM +0100, Alan Cox wrote:
> On Llu, 2005-10-24 at 17:43 +0200, Adrian Bunk wrote:
> > >   CC [M]  drivers/serial/jsm/jsm_tty.o
> > > drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
> > > drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named
> > > `flip'
> > >...
> > 
> > Quoting Andrew's announcement:
> > 
> >    - A number of tty drivers still won't compile.
> 
> Should only be jsm that won't compile for any mainstream platform, if
> you find others that don't please email me.

The other ones I know about on i386 are:
  drivers/char/stallion.c
  drivers/char/istallion.c
  drivers/char/riscom8.c
  drivers/char/rio/riointr.c

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

