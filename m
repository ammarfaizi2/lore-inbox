Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSIFPcj>; Fri, 6 Sep 2002 11:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSIFPci>; Fri, 6 Sep 2002 11:32:38 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:16629
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318738AbSIFPcJ>; Fri, 6 Sep 2002 11:32:09 -0400
Subject: Re: ide drive dying?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209061713.51387.devilkin-lkml@blindguardian.org>
References: <200209061713.51387.devilkin-lkml@blindguardian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 16:38:09 +0100
Message-Id: <1031326689.9861.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 16:13, DevilKin wrote:
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862, 
> sector=1803472

That certainly looks like a drive error.

> The drive involved is an IBM-DTLA-307060, which has served me without problems 
> now for about 2 years.

Get the IBM disk tools, upgrade the firmware and see what the ibm tools
have to say. IBM drives have had some problems with spontaneous bad
blocks appearing that go away with new firmware and a run of the disk
tools. More importantly if thats the problem with the firmware update
they dont come back until the drive really dies.


