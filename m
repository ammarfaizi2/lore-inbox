Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130432AbRCGILq>; Wed, 7 Mar 2001 03:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRCGILg>; Wed, 7 Mar 2001 03:11:36 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:63501 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S130432AbRCGILX>; Wed, 7 Mar 2001 03:11:23 -0500
Date: Wed, 7 Mar 2001 03:22:51 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac13
Message-ID: <20010307032251.A30045@munchkin.spectacle-pond.org>
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Mar 06, 2001 at 10:42:33PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note -- the change in ac4 and beyond to the new aic7xxx scsi driver and
move Doug Ledford's now non-supported driver to aic7xxx-old breaks the pcmcia
3.1.24 release if you configure scsi device support into the kernel.  The
aic7xxx driver is used to support the Adpatec 1480 scsi card.  I have a 1460
scsi card, so I build my laptop release with scsi support included.

I'll post this also to the pcmcia support pages.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
