Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132303AbRACP2y>; Wed, 3 Jan 2001 10:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132266AbRACP2q>; Wed, 3 Jan 2001 10:28:46 -0500
Received: from cmr1.ash.ops.us.uu.net ([198.5.241.39]:7339 "EHLO
	cmr1.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S132307AbRACP23>; Wed, 3 Jan 2001 10:28:29 -0500
Message-ID: <3A533E78.A3F737ED@uu.net>
Date: Wed, 03 Jan 2001 10:00:08 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using a maxtor udma/66 13.6GB drive on the hpt366 for over a
year now with no problems whatsoever... even in udma/66 mode (also with
several different BIOS revisions).  I have not however, ever been able
to get a cdrom to work on this controller either in windows 98/NT or in
linux 2.2/2.4.
I don't think Maxtors should be blacklisted.

Alex

------------------------
On Tue, 2 Jan 2001, David Woodhouse wrote: 
> It's a combination of chipset and drive that causes the problems. I've 
> been using ata66 with the same controller on a different drive 
> (FUJITSU MPE3136AT) for some time now, and it's been rock solid. It's only 
> the IBM DTLA drive that's been a problem on this controller. 

Maxtor has problems with hpt366 also. 

> Highpoint made changes in their 1.26¹ BIOS to correctly support the IBM 
> DTLA drives. If we can get access to information about what they had to 
> change, we ought to be able to get it to work on those drives reliably. 

Too bad Maxtor is still broken with hpt366... 

Also, using CDROM on hpt366 is recipe for disaster... 

-Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
