Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbQLIOSq>; Sat, 9 Dec 2000 09:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbQLIOSg>; Sat, 9 Dec 2000 09:18:36 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:52740 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S130679AbQLIOS1>; Sat, 9 Dec 2000 09:18:27 -0500
Date: Sat, 9 Dec 2000 16:44:53 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davej@suse.de, Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
Message-ID: <20001209164453.A2885@jurassic.park.msu.ru>
In-Reply-To: <Pine.LNX.4.21.0012091233130.4121-100000@neo.local> <E144jVc-0005Lk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E144jVc-0005Lk-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 09, 2000 at 12:53:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 12:53:46PM +0000, Alan Cox wrote:
> If there is surely the driver can override it again before enabling the
> master bit or talking to the device ?

It could be done in PCI_FIXUP_FINAL quirks.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
