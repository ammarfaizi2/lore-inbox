Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275989AbRJGK2C>; Sun, 7 Oct 2001 06:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276234AbRJGK1w>; Sun, 7 Oct 2001 06:27:52 -0400
Received: from www.funmail.co.uk ([212.62.7.9]:4721 "HELO
	mh-a05.dmz.another.com") by vger.kernel.org with SMTP
	id <S275989AbRJGK1l>; Sun, 7 Oct 2001 06:27:41 -0400
Message-ID: <4345806.1002450485849.JavaMail.root@172.16.100.50>
Date: Sun, 7 Oct 2001 11:28:05 +0100 (BST)
From: sven@uncivilised.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 VM problems burning CDs
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1867889.1002450485062.JavaMail.root@www-a21"
X-Funmail-UID: 1801179
X-Senders-IP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--1867889.1002450485062.JavaMail.root@www-a21
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I've found that when I try to burn a CD in 2.4.10 using cdrdao I get the lots of
the following error:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012cd56
This happens every time I burn a CD larger than about 300M. Sometimes 
the OOM killer starts killing processes as well, but I haven't found a reliable
way to reproduce this.

I get no errors using 2.4.9, or if I use cdrecord instead of cdrdao.

Regards,
Steven

--
  Steven Cook
  Perth, Western Australia
  http://www.harshbutfair.org



----------
Get a free, personalised email address at http://another.com
TXT ALRT! Stop wasting money now. Send FREE, personalised txt
from http://another.com
--1867889.1002450485062.JavaMail.root@www-a21--

