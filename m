Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbRABTTJ>; Tue, 2 Jan 2001 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRABTTA>; Tue, 2 Jan 2001 14:19:00 -0500
Received: from pm3-3-38.apex.net ([209.250.40.198]:39434 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131337AbRABTSt>; Tue, 2 Jan 2001 14:18:49 -0500
Date: Tue, 2 Jan 2001 12:48:14 -0600
From: Steven Walter <srwalter@yahoo.com>
To: dep <dennispowell@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-DMA Timeout Bug may be dead...
Message-ID: <20010102124814.B4639@hapablap.dyn.dhs.org>
Mail-Followup-To: dep <dennispowell@earthlink.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101020259080.25365-100000@master.linux-ide.org> <01010209450300.00545@depoffice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01010209450300.00545@depoffice.localdomain>; from dennispowell@earthlink.net on Tue, Jan 02, 2001 at 09:45:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 09:45:03AM -0500, dep wrote:
> if it has anything to do with this, then it's reduced but not gone:
> 
> Jan  2 09:42:35 depoffice kernel: hda: dma_intr: status=0x51 { 
> DriveReady SeekComplete Error }
> Jan  2 09:42:35 depoffice kernel: hda: dma_intr: error=0x84 { 
> DriveStatusError BadCRC }
> 
> via, w.d. drive, error been around for months, no apparent effect 
> except to slow things down a tad and fill /var/log/messages.

I used to get this same message on a SiS530 when I tried to use UDMA3/4
without the 80-conductor cable.  It was also a Western Digital drive.
Fixed after getting the 80-conductor cable.
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
