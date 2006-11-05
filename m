Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWKELd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWKELd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWKELd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:33:58 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:17589 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932653AbWKELd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:33:57 -0500
Date: Sun, 5 Nov 2006 12:33:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: andrew@walrond.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Scsi cdrom naming confusion; sr or scd?
In-Reply-To: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com>
Message-ID: <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr>
References: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "The prefix /dev/sr (instead of /dev/scd) has been deprecated"
>
>but booting 2.6.18.2 from a scsi CD only works if I pass the kernel
>parameter root=/dev/sr0 and fails with root=/dev/scd0
>
>I guess the kernel ought to be taught about the scd* names aswell?

brw-r-----  1 root disk 11, 0 Mar 19  2005 /dev/scd0
brw-r-----  1 root disk 11, 0 Mar 19  2005 /dev/sr0

Plus I see sr0 being far more commonly used than scd0.
So I guess the doc is wrong.


	-`J'
-- 
