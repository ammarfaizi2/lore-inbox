Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVBWRNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVBWRNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVBWRNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:13:10 -0500
Received: from host27.webserver1010.com ([65.109.239.109]:53394 "EHLO
	host27.webserver1010.com") by vger.kernel.org with ESMTP
	id S261501AbVBWRNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:13:05 -0500
Message-Id: <200502231713.j1NHD5Xc011725@host27.webserver1010.com>
From: "Billy Stewart" <stewart@netstarsys.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: the famous Tyan S2885 PCI IDE problem, additional experiences [resolved]
Date: Wed, 23 Feb 2005 12:08:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Thread-Index: AcUZylcxvW9E1BYET5Gf7fl2klkWrg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dap,
  I too have the same problem in relation to the IAL completion errors and
have upgraded from 2.6.9 to 2.6.11.  But now I am unable to compile the
openbuild drivers for the highpoint 1820a raid controllers.

May I ask how you successfully comiled the drivers to work with 2.6.11?

My setup:
Tyan S2882 dual opteron 240
4 gig ram
2 Highpoint 1820a
12 seagate 7200.7 baracudas

Thank you
Billy Stewart


 

-----------------   exerpt below
I've upgraded from 2.6.9 to 2.6.11-rc1 and the problem has been gone! On
Sun, 2005-01-16 at 23:14 +0100, Pallai Roland wrote: > I've read a thread
about Tyan S2885 IDE problems >
(http://www.ussg.iu.edu/hypermail/linux/kernel/0412.3/0457.html), >
unfortunately I suffered from it too, but in a different hardware setup >
and I noticed some more details about it, I hope this may help somehow. > >
My config is a Tyan Thunder K8W (S2885) dual Operon244 with 5 HighPoint >
1820 PCI-X sata controllers and 44/4 SATA/UATA drives, and I get daily > 2-3
messages like this, sometimes followed by a lockup: > > Jan 12 09:16:45
EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 5, flags=101 >
Jan 12 09:16:45 EverDream kernel: Retry on channel(5) > Jan 12 11:05:52
EverDream kernel: IAL: COMPLETION ERROR, adapter 1, channel 7, flags=101 >
Jan 12 11:05:52 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel
7, flags=101 > Jan 12 11:05:52 EverDream kernel: Retry on channel(7) > Jan
12 11:05:52 EverDream kernel: Retry on channel(7) -- dap 
 


