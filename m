Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKHE4q>; Tue, 7 Nov 2000 23:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKHE4g>; Tue, 7 Nov 2000 23:56:36 -0500
Received: from main.cyclades.com ([209.128.87.2]:60164 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129057AbQKHE4Y>;
	Tue, 7 Nov 2000 23:56:24 -0500
Date: Tue, 7 Nov 2000 20:56:22 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Question on new PCI architecture (2.4.x)
Message-ID: <Pine.LNX.4.10.10011072049550.7757-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I was just checking the driver changes needed to comply with the new PCI
architecture in 2.4.x, and then I got into a problem. I noticed that all
drivers that use this architecture (or at least the ones I found, such as
the Tulip, EEPro100, 3c59x ...) support boards with only one net_device
per board. What about boards with more than one net_device??

In my case, the driver supports one- and two-channel boards, and I don't
know how to remove a board that has two net_devices (since
pdev->driver_data can't contain two pointers!! ;).

Also, if anyone could give me pointers to documentation on this new PCI
architecture (sample src code would be great, real documentation, even
better!!), I'd really appreciate it.

Thanks in advance!

Regards,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
