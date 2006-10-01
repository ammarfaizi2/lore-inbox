Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWJAPVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWJAPVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWJAPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:21:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35279 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750955AbWJAPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:21:16 -0400
Subject: Re: zoran driver breaks 'make all{yes,mod}config'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <451F1887.3040102@garzik.org>
References: <451F1887.3040102@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 01 Oct 2006 16:45:47 +0100
Message-Id: <1159717547.13029.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-30 am 21:23 -0400, ysgrifennodd Jeff Garzik:
> drivers/media/video/zoran_driver.c:1519: error: for each function it 
> appears in.)
> 
> Same build breakage in bt484, saa7134.
> 
> The PCIAGP_FAIL symbol doesn't exist anywhere.

As far as I can tell Andrew pushed the PCIAGP_FAIL change to Greg and
the other dependant changes went to Linus.  Just needs the PCIAGP_FAIL
change pushing to Linus tree.

Alan

