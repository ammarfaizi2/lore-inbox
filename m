Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKZVAQ>; Tue, 26 Nov 2002 16:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKZVAQ>; Tue, 26 Nov 2002 16:00:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50956 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261290AbSKZVAP>; Tue, 26 Nov 2002 16:00:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: 2.5.49: Severe PIIX4/ATA filesystem corruption
Date: 26 Nov 2002 13:07:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <as0nq9$vnu$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I finally braved it and tried running 2.5.49 on my workstation to
test out my RAID-6 patches.  There were no patches outside the md
area, and the ordinary filesystems aren't on md drives.

The two SCSI drives (SymBIOS controller) work just fine, but I have
gotten repeated, severe data corruption on the one ATA drive in the
system after only a few hours of operation.

Just thought I'd warn people...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
