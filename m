Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRANDk2>; Sat, 13 Jan 2001 22:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRANDkT>; Sat, 13 Jan 2001 22:40:19 -0500
Received: from SMTP-OUT003.ONEMAIN.COM ([63.208.208.73]:56408 "HELO
	smtp01.mail.onemain.com") by vger.kernel.org with SMTP
	id <S129991AbRANDkJ>; Sat, 13 Jan 2001 22:40:09 -0500
Message-ID: <3A611FCC.931D8CA0@mcn.net>
Date: Sat, 13 Jan 2001 20:41:00 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <20010112212427.A2829@suse.cz> <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com> <20010113150046.E1155@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> Ok, here goes the patch.
> 
> Note that with this patch, all VIA users will get IDE transferrates
> about 3 MB/sec as opposed to about 20 MB/sec without it (and with
> UDMA66).
> 
> This patch disables automatic DMA on all VIA chipsets, including the
> ancient 82c561 for 486's, and up to the 686a UDMA66 chipset.
> 
> Also note that enabling the DMA later with hdparm -X66 -d1 or similar
> command is not safe, and usually works by pure luck on VIA chipsets.
> This however, would need some non-minor changes to the generic code to
> fix.
> 
> But perhaps it's still worth ...
> 
> --
> Vojtech Pavlik
> SuSE Labs
> 
>

_ouch_  Will -X66 -d1c1m16 be as stable with this patch as version 2.1e
has been for me??  It has always (auto)set transfer speeds properly and
I have never seen corruption with my 686a -- 'cept when patching from
test11-pre7 to test12-pre1, and I'm pretty sure that was from other
factors.

===============
-- Tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
