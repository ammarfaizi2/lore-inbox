Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUK0J0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUK0J0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 04:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbUK0J0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 04:26:21 -0500
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:12944
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261164AbUK0J0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 04:26:18 -0500
Message-ID: <41A84875.2030505@freemail.hu>
Date: Sat, 27 Nov 2004 10:27:17 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CD-ROM problem on x86-64
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get sometimes these kind of errors reading continously from CDs:

Nov 26 13:38:09 wl-193 kernel: hda: dma_timer_expiry: dma status == 0x24
Nov 26 13:38:19 wl-193 kernel: hda: DMA interrupt recovery
Nov 26 13:38:19 wl-193 kernel: hda: lost interrupt

and

Nov 26 16:16:50 wl-193 kernel: hdc: DMA interrupt recovery
Nov 26 16:16:50 wl-193 kernel: hdc: lost interrupt

This happens when I use Xine playing AVIs from CDs.
When it happens, it happens frequently, like once in every 5-10 minutes.
When I play an SVCD then it's less frequent than on data CDs,
like once in 30 minutes.

Drive is:

hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive

I haven't seen these kind of errors on my previous FC1/i386 system with
2.6.x kernels, I installed FC3/x86-64 recently. The original and the
second errata kernel both show this errors.

I also don't get this error on my harddisk.

Best regards,
Zoltán Böszörményi
