Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTIALrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbTIALrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:47:31 -0400
Received: from dns.communicationvalley.it ([212.239.58.133]:63369 "HELO
	dns.communicationvalley.it") by vger.kernel.org with SMTP
	id S261702AbTIALra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:47:30 -0400
From: biker@villagepeople.it
Organization: Communication Valley SpA
To: linux-kernel@vger.kernel.org
Subject: pl2303 + uhci oops
Date: Mon, 1 Sep 2003 14:00:08 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011400.08914.biker@villagepeople.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!
Using a pl2303-based usb->serial adaptor with the uhci driver always ends with 
a oops.
Usually, the first serial "session" works fine, but as soon as minicom or any 
other program (kpilot, for example) drops the connection the kernel oopses.
I've been able to reproduce the problem with three different kernels 
(2.4.20-21-22) and two different hardware platform. The first is a Thinkpad 
R40 (Chipset i845, Pentium 4, USB 2.0) and the second is a desktop (KT266A, 
AthlonXP, USB 1.1).
Note that the adaptor works perfectly if the usb-uhci driver is used instead.

Since all the data required to debug the oops take up too much space to be 
included here, I conveniently posted them on my web site in two directories, 
one for the intel machine and the other for the amd.

http://www.villagepeople.it/oops/   (It's just a directory listing, no images, 
banners, redirects or anything else)

Hope this helps.

-Silla

