Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRKSNqQ>; Mon, 19 Nov 2001 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278813AbRKSNqH>; Mon, 19 Nov 2001 08:46:07 -0500
Received: from [212.65.238.182] ([212.65.238.182]:46855 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S278810AbRKSNqC> convert rfc822-to-8bit; Mon, 19 Nov 2001 08:46:02 -0500
Message-ID: <35E64A70B5ACD511BCB0000000004CA1095D08@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: joelbeach@optushome.com.au
Cc: linux-kernel@vger.kernel.org
Subject: RE: Maximum (efficient) partition sizes for various filesystem ty
	pes...
Date: Mon, 19 Nov 2001 13:02:57 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm it looks like that Debians want's to avoid user impatience during
excessive e2fsck job at startup. But technically, one can hardly expect
problems - if there were any, they surely appeared already in this list :) 

Compared to *some* other OSes, linux makes fs checking after certain number
of rw mounts. When thinks like that happen, some less enlightened users tend
to be "derailed", because they don't expect that. :)

Regards,
Petr

> -----Pùvodní zpráva-----
> Od:	Joel Beach [SMTP:joelbeach@optushome.com.au]
> Odesláno:	19. listopadu 2001 11:23
> Komu:	linux-kernel@vger.kernel.org
> Pøedmìt:	Re: Maximum (efficient) partition sizes for various
> filesystem types...
> 
> I think I'll fix up that bit in the Debian manual myself then if they let
> me....
> 
> For what it's worth, here's the paragraph from the "Woody" installation
> manual:
> 
> "For new users, personal Debian boxes, home systems, and other single-user
> setups, a single / partition (plus swap) is probably the easiest, simplest
> way to go. It is possible to have problems with this idea, though, with
> larger (20GB) disks. Based on limitations in how ext2 works, avoid any
> single partition greater than 6GB or so."
> 
> Joel
> 
> ----- Original Message -----
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> To: "Joel Beach" <joelbeach@optushome.com.au>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Monday, November 19, 2001 8:58 PM
> Subject: Re: Maximum (efficient) partition sizes for various filesystem
> types...
> 
> 
> > > For instance, the Debian guide says that, due to Ext2 efficiency,
> partitions
> > > greater than 6-7GB shouldn't be created. Is this true for
> Ext3/ReiserFS.
> >
> > I've run several 45-200Gb ext2 and ext3 partitions with no problem. I'm
> not
> > sure what the origin of the Debian guide comemnt is but I've never heard
> > it from an ext2 developer
> >
> > Obviously pick a journalled fs for big partitions 8)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
