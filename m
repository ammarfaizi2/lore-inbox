Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUFGPoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUFGPoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUFGPoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:44:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20866 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264766AbUFGPn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:43:58 -0400
Date: Mon, 7 Jun 2004 11:43:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: nardelli <jnardelli@infosciences.com>
cc: Greg KH <greg@kroah.com>, Ian Abbott <abbotti@mev.co.uk>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
In-Reply-To: <40C47972.8090703@infosciences.com>
Message-ID: <Pine.LNX.4.53.0406071141090.10324@chaos>
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org>
 <20040605001832.GA28502@kroah.com> <40C47972.8090703@infosciences.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, nardelli wrote:

> Greg KH wrote:
> > On Fri, Jun 04, 2004 at 05:34:41PM +0100, Ian Abbott wrote:
> >
> >>On 04/06/2004 15:59, nardelli wrote:
[SNIPPED...]

> >
> >
> > ===== drivers/usb/serial/visor.c 1.114 vs edited =====
> > --- 1.114/drivers/usb/serial/visor.c	Fri Jun  4 07:13:10 2004
> > +++ edited/drivers/usb/serial/visor.c	Fri Jun  4 17:12:53 2004
>
> ...
>
> Just curious - is there something special about 42?  Grepping wasn't
> very useful, as numbers like this are scattered all over the place.
>
> > +/* number of outstanding urbs to prevent userspace DoS from happening */
> > +#define URB_UPPER_LIMIT	42

See Hitchiker's Guide to the Galaxy. ;^

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


