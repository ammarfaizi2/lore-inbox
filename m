Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAXWjO>; Wed, 24 Jan 2001 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132951AbRAXWjE>; Wed, 24 Jan 2001 17:39:04 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:2066 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129413AbRAXWi5>; Wed, 24 Jan 2001 17:38:57 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF61@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Sasi Peter'" <sape@iq.rulez.org>, linux-kernel@vger.kernel.org
Subject: RE: 2.2.19pre6aa1 USB - Why do I get these?
Date: Wed, 24 Jan 2001 14:32:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Previously unseen. What could be the cause of these messages?
> (Abit BH6 (Intel BX), Logitech Mouseman+ USB)
> 
> Jan 24 21:39:15 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
> requesters
> Jan 24 21:39:16 iq kernel: usb.c: bw_alloc increased by 118 
> to 118 for 1 requesters
..............

These messages have been there all along.  In recent 2.4
kernels, they are #ifdef-ed out.  Same needs to be done
for 2.2.x.

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
