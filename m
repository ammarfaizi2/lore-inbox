Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbTFRSWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbTFRSWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:22:21 -0400
Received: from palrel10.hp.com ([156.153.255.245]:39344 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265447AbTFRSVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:21:03 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.45266.649753.218407@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 11:34:58 -0700
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Check in new SN2 file from Jes' gettimeoffset() patch.
In-Reply-To: <Pine.GSO.4.21.0306182003320.7606-100000@vervain.sonytel.be>
References: <200306181626.h5IGQbH4027481@hera.kernel.org>
	<Pine.GSO.4.21.0306182003320.7606-100000@vervain.sonytel.be>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 20:04:25 +0200 (MEST), Geert Uytterhoeven <geert@linux-m68k.org> said:

  >> diff -Nru a/timer.c b/timer.c
  >> --- /dev/null	Wed Dec 31 16:00:00 1969
  >> +++ b/timer.c	Wed Jun 18 09:26:40 2003
  Geert> ^^^^^^^
  >> @@ -0,0 +1,85 @@
  >> +/*
  >> + * linux/arch/ia64/sn/kernel/sn2/timer.c
  Geert> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Geert> Just wondering, did this file really end up where it belongs?

I think it did, eventually: there was another change to undo the
breakage.  What happened is that due to some error, the file ended up
in the wrong place in the ia64 linux tree at some point.  I then
deleted the bogus file.  Unfortunately, you can't make bk forgive such
sins...

	--david
