Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266201AbSKFWuQ>; Wed, 6 Nov 2002 17:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266202AbSKFWuQ>; Wed, 6 Nov 2002 17:50:16 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:34315 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S266201AbSKFWuP>; Wed, 6 Nov 2002 17:50:15 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB184D@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'bert hubert'" <ahu@ds9a.nl>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Regarding zerocopy implementation ...
Date: Wed, 6 Nov 2002 14:56:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, but what abt the support in the kernel?

-----Original Message-----
From: bert hubert [mailto:ahu@ds9a.nl]
Sent: Wednesday, November 06, 2002 2:48 PM
To: 'linux-kernel@vger.kernel.org'
Subject: Re: Regarding zerocopy implementation ...


On Wed, Nov 06, 2002 at 05:44:18PM -0500, Benjamin LaHaise wrote:

> > Yes, we have zero-copy networking if the device supports the requisite
> > features and the driver is so coded.
> 
> But we do not perform zero copy receives to userland yet.

It has been opted that sendfile with reversed arguments could function as
'recvfile' and be renamed to 'copyfd' or something more generic like that.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
