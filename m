Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbSI2Tqe>; Sun, 29 Sep 2002 15:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbSI2Tqe>; Sun, 29 Sep 2002 15:46:34 -0400
Received: from ASte-Genev-Bois-101-1-3-193.abo.wanadoo.fr ([193.252.180.193]:49420
	"EHLO slartibartfast.ouaou.org") by vger.kernel.org with ESMTP
	id <S261758AbSI2Tq3>; Sun, 29 Sep 2002 15:46:29 -0400
Date: Sun, 29 Sep 2002 21:51:50 +0200
From: Ignacy Gawedzki <ig@zenon.netmonk.org>
To: linux-kernel@vger.kernel.org
Subject: DMA audio-CD extraction/writing and ide-scsi
Message-ID: <20020929215150.A2049@zenon.ouaou.org>
Mail-Followup-To: Ignacy Gawedzki <ig@zenon.netmonk.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I resign to post the question directly here after hours of vain
searching on other sources of information. If the question has already
been answered hundreds of times, I am *really* sorry about the mess...
(I also tried to check on the latest development version, but failed at
booting the system at all).

I would like to know if there is a particular reason that forbids audio
extraction/writing from/of CDs using UDMA (as opposed to PIO) when using
the ide-scsi driver.

Apparently the problem seems not to be such an issue as it seems that
very few people extract audio data from CDs and/or write audio CDs. But
still...

I already applied a patch from akpm to make audio extraction use DMA
with the ide-cd driver. It works very fine for me and I miss the feature
really badly on the ide-scsi driver.

If there are some SCSI gurus here willing to enlight me on this specific
issue, I will be very thankful. =)

Regards,

Ignacy Gawedzki

-- 
I drive way too fast to worry about cholesterol.
