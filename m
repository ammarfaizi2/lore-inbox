Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJNDhr>; Sat, 13 Oct 2001 23:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJNDhh>; Sat, 13 Oct 2001 23:37:37 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:52716 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S273854AbRJNDhS>; Sat, 13 Oct 2001 23:37:18 -0400
Mime-Version: 1.0
Message-Id: <p04320401b7eeb405a4a8@[12.79.180.246]>
In-Reply-To: <20011013190658.A32535@hapablap.dyn.dhs.org>
In-Reply-To: <01101319043002.01369@gabrielle.pdickson.newboston.nh.us>
 <20011013190658.A32535@hapablap.dyn.dhs.org>
Date: Sat, 13 Oct 2001 23:21:58 -0400
To: Steven Walter <srwalter@yahoo.com>
From: pd <pdickson@att.net>
Subject: Re: PCI modem doesn't work after 2.4.2->2.4.10 upgrade
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Unlike 2.4.2, 2.4.10 can automatically detect and configure PCI modems.
>That's why its already in use to setserial.  The kernel has already
>found your modem, and assigned it ttyS4 (0-3 are reserved for the
>standard COM1-4).  Theoretically, then, all you have to do is relink
>/dev/modem to /dev/ttyS4, and you should be set.

That is exactly what it turned out to be.  Tnx.  Works fine now.

>If you had read through 'dmesg', and the problem if what I suspect it
>is, you would have seen this pretty obviously.

I looked in dmesg and there it was, now that I know what to look for.

I also found a "redundant entry in serial pci_table" message and will
be sending the requested message off to serial-pci-info@lists.sourceforge.net.
-- 

-pd
