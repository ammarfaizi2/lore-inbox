Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUEWUHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUEWUHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUEWUHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:07:24 -0400
Received: from herkules.viasys.com ([194.100.28.129]:9640 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S263475AbUEWUHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:07:22 -0400
Date: Sun, 23 May 2004 23:07:16 +0300
From: Ville Herva <vherva@viasys.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-mm4 IDE] HPT370A/i815 ATAPI problems
Message-ID: <20040523200716.GZ23361@viasys.com>
Reply-To: vherva@viasys.com
References: <20040522185604.GA11309613@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522185604.GA11309613@niksula.cs.hut.fi>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 09:56:06PM +0300, you [Ville Herva] wrote:
>
> And I just noticed DMA is not enabled for DW-7802TE when attached to HPT.

I tried manually enabling DMA for hdg (Mitsumi 7802TE on HPT370A.) I get:

hdg: DMA timeout retry
hdg: 0 bytes in FIFO
hdg: timeout waiting for DMA
hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdg: status error: error=0x00
hdg: drive not ready for command
hdg: status timeout: status=0xd8 { Busy }
hdg: status timeout: error=0xd8MediaChangeRequested LastFailedSense 0x0d 
hdg: drive not ready for command
hdg: ATAPI reset complete
hdg: 0 bytes in FIFO
hdg: timeout waiting for DMA
hdg: 0 bytes in FIFO
hdg: timeout waiting for DMA
hdg: 0 bytes in FIFO
hdg: timeout waiting for DMA
hdg: 0 bytes in FIFO
hdg: timeout waiting for DMA
hdg: DMA disabled

while trying to rip audio cd, and the rip does not progress at all. Doesn't
lock up, though. The cd writer (Mitsumi 4804TE) did function as hdg with DMA
enabled (and it got enabled by default.)

So my original question stays: is there any change a firmware upgrade could
help? (I'm kind of wary of trying random firmwares, since Mitsumi doesn't
seem to provide one, and the most linked firmware site
(http://www.herrie.org/) says it was just defaced in the front page...
Besides all those firmwares are either "hacked" or "modified".)

What else might be the problem?


-- v -- 

v@iki.fi

