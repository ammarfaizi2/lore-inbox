Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSBATvB>; Fri, 1 Feb 2002 14:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291945AbSBATuw>; Fri, 1 Feb 2002 14:50:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18598 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291943AbSBATur>;
	Fri, 1 Feb 2002 14:50:47 -0500
Date: Fri, 1 Feb 2002 14:50:44 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Rob Landley <landley@trommello.org>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020201145044.C32553@havoc.gtf.org>
In-Reply-To: <20020131.162549.74750188.davem@redhat.com> <E16WRmu-0003iO-00@the-village.bc.nu> <20020131.163054.41634626.davem@redhat.com> <20020201193620.IWZK8351.femail40.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201193620.IWZK8351.femail40.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Feb 01, 2002 at 02:37:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 02:37:30PM -0500, Rob Landley wrote:
> On Thursday 31 January 2002 07:30 pm, David S. Miller wrote:
> >    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >    Date: Fri, 1 Feb 2002 00:42:44 +0000 (GMT)
> >
> >    I'd like to eliminate lots of the magic weird cases in Config.in too -
> > but by making the language express it. Something like
> >
> >    tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL
> >
> > This doesn't solve the CRC32 case.  What if you want
> > CONFIG_SMALL, yet some net driver that needs the crc32
> > routines?
> 
> I thought this was the sort of reason CML2 was invented?

This case is handled now, CML2 is not needed for this.

RTFS

	Jeff, allowing himself to be trolled



