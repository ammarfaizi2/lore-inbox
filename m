Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRDFSHx>; Fri, 6 Apr 2001 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRDFSHe>; Fri, 6 Apr 2001 14:07:34 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.121.49]:35209 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S132226AbRDFSHU>; Fri, 6 Apr 2001 14:07:20 -0400
Date: Fri, 6 Apr 2001 13:43:12 -0400 (EDT)
From: isaac albeniz <albeniz@earthlink.net>
X-X-Sender: <albeniz@glass.pipe.org>
To: <linux-kernel@vger.kernel.org>
Subject: modutils / sound
Message-ID: <Pine.LNX.4.33.0104061340250.17608-100000@glass.pipe.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just upgraded to modutils 2.4.5, and my sound modules wont autoload
anymore. They work fine if i manually load them but that is an
unacceptable solution.

alias char-major-14 sb
options sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x330
options sound dmabuf=1

Those are the lines ive always used in modules.conf and have always worked
till i upgraded.

Any suggestions? Please CC me im not on the list.

