Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQKOTjh>; Wed, 15 Nov 2000 14:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129928AbQKOTjP>; Wed, 15 Nov 2000 14:39:15 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:18189 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129485AbQKOTjN>; Wed, 15 Nov 2000 14:39:13 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD0F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'aprasad@in.ibm.com'" <aprasad@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: RE: keyboard lockup after kdb session
Date: Wed, 15 Nov 2000 09:24:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the same problem with kdb.

In a controlled environment, I always start a script
before entering kdb:

  while [ 1 ] ; do
    sleep 3
    /etc/rc.d/init.d/gpm restart > /dev/null
  done

This will re-enable the kbd every 3 seconds.

But it would be nice to find the problem, eh?

~Randy_________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> -----Original Message-----
> From: aprasad@in.ibm.com [mailto:aprasad@in.ibm.com]
> Sent: Wednesday, November 15, 2000 4:51 AM
> To: linux-kernel@vger.kernel.org
> Subject: keyboard lockup after kdb session
> 
> 
> Hi,
> I am new to kdb. my keyboard is locked after kdb-session (either by
> generating oops or manual).
> is there any way to restore it without rebooting...
> thanks
> anil
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
