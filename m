Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRAKPNX>; Thu, 11 Jan 2001 10:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131879AbRAKPNN>; Thu, 11 Jan 2001 10:13:13 -0500
Received: from [216.151.155.116] ([216.151.155.116]:6923 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129927AbRAKPND>; Thu, 11 Jan 2001 10:13:03 -0500
To: James Brents <James@nistix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
In-Reply-To: <3A5DB638.1050809@nistix.com>
From: Doug McNaught <doug@wireboard.com>
Date: 11 Jan 2001 10:12:54 -0500
In-Reply-To: James Brents's message of "Thu, 11 Jan 2001 07:33:44 -0600"
Message-ID: <m34rz6rukp.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Brents <James@nistix.com> writes:

> Hello,
> Since this looks like either a chipset, drive, or driver problem, I am
> submitting this.
> 
> I have recently started using DMA mode on my harddisk. However, I occasionally
> (not often/constant, but sometimes) get CRC errors:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

You might try testing with a different drive if you can get hold of
one--if that works OK, that'll narrow it down to either a drive or
drive-chipset interaction.  The above error message could very well
mean that you're starting to lose the drive, so keep backups!

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
