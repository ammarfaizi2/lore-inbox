Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSLITzO>; Mon, 9 Dec 2002 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSLITzO>; Mon, 9 Dec 2002 14:55:14 -0500
Received: from fmr02.intel.com ([192.55.52.25]:39652 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265898AbSLITzN>; Mon, 9 Dec 2002 14:55:13 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Ducrot Bruno'" <poup@poupinou.org>, Pavel Machek <pavel@suse.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: RE: [ACPI] Re: [2.5.50, ACPI] link error
Date: Mon, 9 Dec 2002 11:12:43 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ducrot Bruno [mailto:poup@poupinou.org] 

> > I think that s4bios is nice to have. Its similar to S3 and easier to
> > set up than swsusp... It would be nice to have it.
> 
> for me:
> pros:
> -----
> 1- it is really really more easier to implement than S4;
> 2- we can even have it with 2.4 kernels (it seems that it work without
> the need of freezing processes, but I suspect that this statement
> is 'wrong' by nature).
> 
> cons:
> -----
> 1- it is much slower (especially at save time) than your swsusp;
> 2- end users must setup their systems (need to create a 
> suspend partition,
> or to keep a vfat partition as the really first one (/dev/hda1));
> 3- we use a bios function.  Actually, everything can happen...
> 
> That why I prefer swsusp at this time, or any other 
> implementation of S4 (I
> think about an implementation of S4 via LKCD).

I concur with your pros and cons. This makes me think that if S4BIOS support
ever gets added, it should get added to 2.4 only.

Regards -- Andy
