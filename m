Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbRG0OE4>; Fri, 27 Jul 2001 10:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267986AbRG0OEr>; Fri, 27 Jul 2001 10:04:47 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:54794 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S267974AbRG0OEf>;
	Fri, 27 Jul 2001 10:04:35 -0400
Date: Fri, 27 Jul 2001 16:04:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Graphical overview
Message-ID: <20010727160440.B14483@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010727145202.A507@freakzone.net> <200107271337.f6RDbVN22777@syntags.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107271337.f6RDbVN22777@syntags.de>; from ffiene@veka.com on Fri, Jul 27, 2001 at 03:37:31PM +0200
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 03:37:31PM +0200, Frank Fiene wrote:
> On Friday, 27. July 2001 14:52, Gordon Fraser wrote:
> > Frank Fiene <ffiene@veka.com> [010727 13:19] wrote:
> > > Where can i find the graphical overview of the linux kernel
> > > source tree? I saw a big jpg and a link to a homepage, but i lost
> > > the informations.
> >
> > This is what you're looking for:
> > http://fcgp.sourceforge.net/
> 
> Thanks, Gordon and Jan-Benedict.
> 
> lgp version 2.4.0a works fine but the latest 2.5.1 does not. Compile 
> error is
> data2ps.o: In function `d2p_draw_line':
> /home/ffiene/docs/lgp-2.5.1/data2ps.c:180: undefined reference to 
> `cos'
> /home/ffiene/docs/lgp-2.5.1/data2ps.c:181: undefined reference to 
> `sin'

Add "-lm" somewhere to the compile call. It's missing to include
the mathematical library. So it's a bug in the makefile.

MfG, JBG

