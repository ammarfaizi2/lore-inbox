Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRHVV5s>; Wed, 22 Aug 2001 17:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272142AbRHVV5i>; Wed, 22 Aug 2001 17:57:38 -0400
Received: from mail.deja.com ([65.195.161.135]:60678 "EHLO mail.deja.com")
	by vger.kernel.org with ESMTP id <S272137AbRHVV5W>;
	Wed, 22 Aug 2001 17:57:22 -0400
From: "Jeff Busch" <jbusch@half.com>
To: <linux-kernel@vger.kernel.org>, <roswell-list@redhat.com>
Subject: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
Date: Wed, 22 Aug 2001 16:57:35 -0500
Message-ID: <NEBBJGKHGENBAPAMDILGIEFGGOAA.jbusch@half.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

machine:  Compaq Proliant DL360 w/4GB mem, dual 36GB SCSI drives
OS:	    RedHat 7.1 + errata updates, kernel-enterprise-2.4.7-2.i686.rpm from
'Roswell 2'

Under heavy I/O (Apache and a custom C++ module which do lots of mmap and
munmap calls over large data sets - 7GB total), the machine slows to a
crawl.  The problem persists even after live traffic to the machine ceases.
A top listing shows both cpu's at 100% system.  Any commands (ps, uname,
whatever) take minutes to return results.

The same setup on RH 6.2 with 2.4.3-ac3 works fine.  Please let me know what
information may be useful to debugging this problem (no oops yet), and other
kernels to try; I'm looking at 2.4.8-ac9 right now.

Thanks,
Jeff Busch
System Administrator
Half.com - an eBay company

