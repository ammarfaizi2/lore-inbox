Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754781AbWKIKKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbWKIKKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 05:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbWKIKKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 05:10:04 -0500
Received: from stingr.net ([212.193.32.15]:53454 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S1754781AbWKIKKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 05:10:01 -0500
Date: Thu, 9 Nov 2006 13:09:53 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
Message-ID: <20061109100953.GE2226@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a couple of old SMP systems (Dual P3 on Intel STL2 boards), on
which I experience the following:
procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu------
 0  0      0 800752  45376 143064    0    0     0     8 96607   65  0 0 100  0  0
 0  0      0 800752  45376 143064    0    0     0     0 96439   57  0 0 100  0  0

It's a completely idle system. Interrupts are coming from rtc.
This is a stock fedora SMP kernel.

IIRC, some time ago (years) I've read that rtc can be used somehow in
SMP but I don't remember the specifics. So, maybe you are familiar
with this and can give out a quick answer - what this 100K
interrupts/sec are about, and how to get rid of them (if possible).

Thanks!

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
