Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUINIVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUINIVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUINIVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:21:01 -0400
Received: from dialup-4.246.93.207.Dial1.SanJose1.Level3.net ([4.246.93.207]:61056
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S269201AbUINIUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:20:47 -0400
Reply-To: <syphir@syphir.sytes.net>
From: "C.Y.M." <syphir@syphir.sytes.net>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Date: Tue, 14 Sep 2004 01:20:21 -0700
Organization: CooLNeT
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAlWQshEZFqEyYIBOxibqMHgEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSaKuS7nVobyvWZSCCSRVMFZYOtaAACFDEg
In-Reply-To: <20040914071555.GJ2336@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Forgot to attach the code, here it is...
> 

When I use your test application on the disabled drives, I get the following
results:

issuing FLUSH_CACHE: worked
issuing FLUSH_CACHE_EXT: failed 0x51/0x4!

Is FLUSH_CACHE_EXT also a requirement?  Would it not be possible to just add
this test function to ide-probe.c instead of looking for what the drive may
or may not be advertising properly?

--
C.Y.M.

