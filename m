Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSKFB7k>; Tue, 5 Nov 2002 20:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKFB7j>; Tue, 5 Nov 2002 20:59:39 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:35601 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265516AbSKFB7a>; Tue, 5 Nov 2002 20:59:30 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1837@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Adam Radford'" <aradford@3WARE.com>,
       Manish Lachwani <manish@Zambeel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 0x40 errors reported by 3ware controllers ...
Date: Tue, 5 Nov 2002 18:05:57 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam,

Thanks for the response. What is the ECC error timeout in the 3ware 7.5
firmware? Will a RESET sequence in the driver for 0x40 help?

Thnaks
manish

-----Original Message-----
From: Adam Radford [mailto:aradford@3WARE.com]
Sent: Tuesday, November 05, 2002 4:01 PM
To: 'Manish Lachwani'; 'linux-kernel@vger.kernel.org'
Subject: RE: 0x40 errors reported by 3ware controllers ...


Manish,

We are not aware of any issue regarding misreporting of ECC errors.  All
uncorrectable
errors seen by the controller are actually uncorrectable errors passed
through from the
drives.  ECC could be due to vibration, shocks, heating, etc, related to
your enclosure.

Please email 3ware output from /var/log/messages and firmware log to
support@3ware.com
and we will take a look at this issue.  

--
Adam Radford
Software Engineer
3ware, Inc.

-----Original Message-----
From: Manish Lachwani [mailto:manish@Zambeel.com]
Sent: Tuesday, November 05, 2002 1:43 PM
To: 'linux-kernel@vger.kernel.org'
Cc: Manish Lachwani
Subject: 0x40 errors reported by 3ware controllers ...


Hello,
We are making use of 3ware 7x50 controllers with Maxtor and Seagate drives.
In one such setup, the operating temperature of the drives/controllers is
between 45-55 C. Numerous 0x40 Error messages are reported by the 3ware
firmware. We are making use of 7.5 latest firmware and the latest 3ware
driver with the 2.4.17 kernel. 
I spoke with Maxtor and Seagate support and they claim that ECC errors are
rarely seen on their drives at even higher temperatures. Are there any
issues with the 3ware controllers/firmware that may cause it to misreport
ECC errors? Maxtor even claimed that it could be errors with the SRAM on the
controller. Could that be possible? Has this been seen? I noticed that the
operating temperature of the controllers is 40C. What kind of errors can
occur because of these ambient conditions?
We are seeing these errors accross different types of drives too ...
Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
