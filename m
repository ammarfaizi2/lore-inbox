Return-Path: <linux-kernel-owner+w=401wt.eu-S932713AbWLNNHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWLNNHX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWLNNHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:07:23 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57599 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932714AbWLNNHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:07:21 -0500
Date: Thu, 14 Dec 2006 13:55:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: =?UTF-8?B?SGFucy1Kw7xyZ2Vu?= Koch <hjk@linutronix.de>,
       Hua Zhong <hzhong@gmail.com>, "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061214124241.44347df6@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612141354410.6223@yvahk01.tjqt.qr>
References: <4580E37F.8000305@mbligh.org> <003801c71f45$45d722c0$6721100a@nuitysystems.com>
 <20061214111439.11bed930@localhost.localdomain> <200612141231.17331.hjk@linutronix.de>
 <20061214124241.44347df6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-818596626-1166100947=:6223"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-818596626-1166100947=:6223
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 14 2006 12:42, Alan wrote:
>On Thu, 14 Dec 2006 12:31:16 +0100
>Hans-Jürgen Koch <hjk@linutronix.de> wrote:
>> You think it's easier for a manufacturer of industrial IO cards to
>> debug a (large) kernel module?
>
>You think its any easier to debug because the code now runs in ring 3 but
>accessing I/O space.

A NULL fault won't oops the system, but of course the wrong inb/inw/inl() or
outb* can fubar the machine.


>> > uio also doesn't handle hotplug, pci and other "small" matters.
>> 
>> uio is supposed to be a very thin layer. Hotplug and PCI are already
>> handled by other subsystems. 
>
>And if you have a PCI or a hotplug card ? How many industrial I/O cards
>are still ISA btw ?

Something called PC104 out there.


	-`J'
-- 
--1283855629-818596626-1166100947=:6223--
