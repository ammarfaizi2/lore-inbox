Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQJ3IW5>; Mon, 30 Oct 2000 03:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQJ3IWr>; Mon, 30 Oct 2000 03:22:47 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:38661 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129034AbQJ3IWh>; Mon, 30 Oct 2000 03:22:37 -0500
Message-ID: <00a901c0424a$d5b388e0$589ca19b@corp.fedex.com>
From: "Jeff Chua" <jchua@fedex.com>
To: <linux-kernel@vger.kernel.org>
Subject: initrd broken???
Date: Mon, 30 Oct 2000 16:24:26 +0800
Organization: FedEx
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting this hoping that someone will fix this soon ...

On Sat, 28 Oct 2000, Jeff Chua wrote:

> freeram /dev/ram0
> File freeram.c: Line 41: ioctl /dev/ram0: Error 16: Device or resource
busy

this should not happen.

> I cannot free the old initrd root partition under 2.4.0-testx, but it
works
> fine on 2.2.17.

hmm, as initrd now is used by almost evry Linux distributor, there for
sure will be a fix sooner or later if it is broken ;-)
... just wait a bit or complain on linux-kernel@vger.kernel.org

Hans
<lermen@fgan.de>


original message ...


Any chance to fix the following bug in 2.4.x

dmesg (from bootup message) ...
change_root: old root has d_count=3

freeram /dev/ram0
File freeram.c: Line 41: ioctl /dev/ram0: Error 16: Device or resource busy

I cannot free the old initrd root partition under 2.4.0-testx, but it works
fine on 2.2.17. I used loadlin to boot up
ramdisk initrd first, load the ide driver, and boot up the real linux.

I hope you guys are still the one maintaining initrd, if not, please point
me to someone who can help,
or send me a few lines as to how I can fix this.


Thanks,
Jeff
[ jchua@fedex.com ]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
