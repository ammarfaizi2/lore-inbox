Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277109AbRJHTrg>; Mon, 8 Oct 2001 15:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277106AbRJHTrO>; Mon, 8 Oct 2001 15:47:14 -0400
Received: from peace.netnation.com ([204.174.223.2]:56080 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277099AbRJHTrI>; Mon, 8 Oct 2001 15:47:08 -0400
Date: Mon, 8 Oct 2001 12:47:38 -0700
From: Simon Kirby <sim@netnation.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Greg KH <greg@kroah.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5
Message-ID: <20011008124738.J8703@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com> <20011007121851.A1137@netnation.com> <20011007153433.G14479@sventech.com> <20011007124038.A22923@netnation.com> <20011007161903.H14479@sventech.com> <20011008120223.G8703@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20011008120223.G8703@netnation.com>; from sim@netnation.com on Mon, Oct 08, 2001 at 12:02:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 12:02:23PM -0700, Simon Kirby wrote:

> On Sun, Oct 07, 2001 at 04:19:03PM -0400, Johannes Erdfelt wrote:
> 
> > Ahh, could you replace this line:
> > 
> >         pci_write_config_word(uhci->dev, USBLEGSUP, 0);
> > 
> > with this:
> > 
> >         pci_write_config_word(uhci->dev, USBLEGSUP, USBLEGSUP_DEFAULT);
> > 
> > and try again?
> 
> Yes, this fixed it.  Thanks.

However, now the downloading from my digital camera (Kodak DC290) is
abysmally slow...about a magnitude slower.  usb-uhci instead goes at
the same speed as before.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
