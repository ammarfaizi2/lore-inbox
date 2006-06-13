Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWFMR5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWFMR5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFMR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:57:39 -0400
Received: from mail.gmx.net ([213.165.64.21]:32729 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750936AbWFMR5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:57:38 -0400
X-Authenticated: #5598835
Content-Disposition: inline
From: Christian =?iso-8859-1?q?H=E4rtwig?= <christian.haertwig@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: How does RAID work with IT8212 RAID PCI card?
Date: Tue, 13 Jun 2006 19:57:34 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200606131957.34942.christian.haertwig@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No not true, i have this card and its a true hardware raid card. The
> thing is, this card has both a raid and a passthru mode, you should
> check which bios is flashed into it. Google is your friend.

Wow, this really has helped it seems!

I gave the card to a friend who flashed a different BIOS version into it
 (BIOS 1.4.1.6). This BIOS is old, but even newer than the one which was
 installed before. I had to recreate the RAID array and now dmesg shows me:

hde: Integrated Technology Express Inc, ATA DISK drive
hde: IT8212 Bootable RAID 1 volume.

... and no hdg anymore. I guess that was what i wanted :)
Thank you!

Yours sincerely,
Christian Haertwig
