Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276809AbRJCAVp>; Tue, 2 Oct 2001 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276807AbRJCAVf>; Tue, 2 Oct 2001 20:21:35 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:31504 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S276806AbRJCAVY>;
	Tue, 2 Oct 2001 20:21:24 -0400
Date: Tue, 2 Oct 2001 21:22:41 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: linux-kernel@vger.kernel.org
Subject: VIA status
Message-ID: <Pine.GSO.4.21.0110022115590.11790-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

Any news from VIA if it's OK to reprogram bit 55.1 of the host bridge, to 
fix the K7 optimizations?

Also, is there already a fix for those who get 
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command

when using CONFIG_BLK_DEV_VIA82CXXX=y ?

My system will do it with this option, but work OK without, although I
haven't measured performance differences. I see many people reporting
similar problems on the archives, but no definite fix. hda is an old 4GB
Western Digital HD that can only do PIO mode 4, I believe. It has a ATAPI
ZIP drive as slave.

Running 2.4.10 here.

TIA,

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

