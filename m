Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130157AbRAMOFr>; Sat, 13 Jan 2001 09:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbRAMOFf>; Sat, 13 Jan 2001 09:05:35 -0500
Received: from styx.suse.cz ([195.70.145.226]:47605 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130144AbRAMOF2>;
	Sat, 13 Jan 2001 09:05:28 -0500
Date: Sat, 13 Jan 2001 14:45:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010113144528.D1155@suse.cz>
In-Reply-To: <20010112212427.A2829@suse.cz> <E14HDv7-0005G6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14HDv7-0005G6-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 12, 2001 at 11:47:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 11:47:41PM +0000, Alan Cox wrote:

> > However - Alan's IDE patch for 2.2 kills autodma on ALL VIA chipsets.
> > That's because all VIA chipsets starting from vt82c586 to vt82c686b
> > (UDMA100), share the same PCI ID.
> 
> I have no reports of problems with the later stuff

At least the one you sent to me is about 586b. Which is the later stuff.

> > Would you prefer to filter just vt82c586 and vt82c586a as the comment in
> > Alan's code says or simply unconditionally kill autodma on all of VIA
> > chipsets, as Alan's code does?
> 
> I'd take a 2.2 patch to cut down the range too

I can make one for you, but first I'd like to find out what exactly are
the problem cases.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
