Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135490AbRDZXtb>; Thu, 26 Apr 2001 19:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbRDZXtW>; Thu, 26 Apr 2001 19:49:22 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:43275 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S135490AbRDZXtQ>; Thu, 26 Apr 2001 19:49:16 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.3-ac13 vm issue?
Date: Thu, 26 Apr 2001 16:47:54 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHAEPKGGAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not really sure what happened here, but kernel logfile and serial
console log said this:

__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
eth0: memory shortage
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.

...

System was unstable and hard-locked when I did a sysrq-p.  syslog died when
the error showed up, so no data is available.  There's 1GB in this system
with Apache (128 children) and MySQL (192MB keycache) running.

I'm not sure how to recreate the error.  System was running fine for 5 days
before it showed up.

-Vibol

