Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRABPMx>; Tue, 2 Jan 2001 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbRABPMm>; Tue, 2 Jan 2001 10:12:42 -0500
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:13035 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129962AbRABPM1>; Tue, 2 Jan 2001 10:12:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-DMA Timeout Bug may be dead...
Date: Tue, 2 Jan 2001 09:45:03 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10101020259080.25365-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10101020259080.25365-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <01010209450300.00545@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 January 2001 06:00 am, Andre Hedrick wrote:
| Doing final tests but it may have come to and end and that deadlock
| may be gone in a few hours after some sleep.

if it has anything to do with this, then it's reduced but not gone:

Jan  2 09:42:35 depoffice kernel: hda: dma_intr: status=0x51 { 
DriveReady SeekComplete Error }
Jan  2 09:42:35 depoffice kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }

via, w.d. drive, error been around for months, no apparent effect 
except to slow things down a tad and fill /var/log/messages.

-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
