Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132470AbRCaRy6>; Sat, 31 Mar 2001 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRCaRyt>; Sat, 31 Mar 2001 12:54:49 -0500
Received: from jffdns01.or.intel.com ([134.134.248.3]:48402 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S132470AbRCaRyf>; Sat, 31 Mar 2001 12:54:35 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE17F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: using ioctls (was: RE: Larger dev_t)
Date: Sat, 31 Mar 2001 09:53:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

Tangential question (I think).  Not for an IOCTL request  8;)
[as the JFS request last week].

[When] is it OK to use (new) IOCTLs vs. using procfs read/write?

And are there some alternative methods besides these two?

Thanks,
~Randy


> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> 
...
> We should encourage people to not need major numbers. It's easy. The
> driver exports a /proc entry in /proc/driver/xxx or similar . Or the
> driver writer says "if you want to use this device, use devfs", and
> exports the name there.

