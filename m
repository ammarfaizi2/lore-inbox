Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272784AbRIGRZd>; Fri, 7 Sep 2001 13:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272791AbRIGRZY>; Fri, 7 Sep 2001 13:25:24 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42479
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272784AbRIGRZL>; Fri, 7 Sep 2001 13:25:11 -0400
Date: Fri, 7 Sep 2001 10:25:25 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
Message-ID: <20010907102525.T29607@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <PAEKIKPEKOCEFPAENNPCOELICBAA.blackfoot@yifan.net> <200109070839.f878dIw00545@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109070839.f878dIw00545@sunrise.pg.gda.pl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 10:39:18AM +0200, Andrzej Krzysztofowicz wrote:
> "Jim Blomo wrote:"
> > Hi, I am having a similar problem with my new board/chip. I am using
> > 2.4.10-pre4, and when I compile with the Athlon/Thunderbird setting, the
> > kernel does absolutely nothing after being uncompressed by LILO. The
> > computer locks up and I must do a hard reboot to get going again. I have had
> > no errors (for about 1.5 days) when using the same kernel compiled as 386
> > and Pentium pro without any other changes. When I used make bzdisk and tried
> > to boot from that, it repeated the following message over and over until I
> > did a soft reset:
> > 
> > 1007
> > AX:020C
> > BX:0000
> > CX:0007
> > DX:0000
> 
> This has nothing to do with Athlon optimization. This is probably a broken
> floppy disk.
> 
> This seem to be from the bootsector code from arch/i386/bootsect.S, it is
> exactly the same for all x86 processors and called before any other code.

That still doesn't discount the report because booting was also tried from
the hard disk.
