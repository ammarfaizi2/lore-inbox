Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSE2RpA>; Wed, 29 May 2002 13:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSE2Ro6>; Wed, 29 May 2002 13:44:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6904 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314396AbSE2Roi>; Wed, 29 May 2002 13:44:38 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Gerald Champagne <gerald@io.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CF4F7E8.2020300@evision-ventures.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 19:47:13 +0100
Message-Id: <1022698033.12888.279.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 16:46, Martin Dalecki wrote:
> Indeed thanks for the reminder. However as far as I'm concerned
> I would rather agree that the data currently present in those
> black/whitelists is basically useless. Most of the disks
> present there are simple plain just obsoleted by a great margin

Lots of people are still using them. Removing the blacklists "because
they are old disks" is not what I'd consider good practice.

> It's most propably not accurate for more modenr ATA host chip cells.

For the DMA blacklists thats not the case. You need to get more direct
contacts with the IDE/ATA drive vendors and documentation sets. The WDC
DMA blacklist entries for example are from specific WDC issued lists of
problem drives. 

Alan

