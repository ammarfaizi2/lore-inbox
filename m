Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTALUjL>; Sun, 12 Jan 2003 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbTALUjL>; Sun, 12 Jan 2003 15:39:11 -0500
Received: from [212.27.202.178] ([212.27.202.178]:62849 "EHLO sakal.vgd.cz")
	by vger.kernel.org with ESMTP id <S267408AbTALUjK>;
	Sun, 12 Jan 2003 15:39:10 -0500
Subject: Problems with USB
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF5C27F452.AC6AECA2-ONC1256CAC.0070FAA4@vgd.cz>
From: Petr.Titera@whitesoft.cz
Date: Sun, 12 Jan 2003 21:44:42 +0100
X-MIMETrack: Serialize by Router on Sakal/SRV/SOCO/CZ(Release 5.0.8 |June 18, 2001) at
 12.01.2003 21:53:48
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

     I have problems with USB in recent kernels (tested on 2.5.56) and
RedHat 8.0. Right after end of script  '/etc/rc.d/rc.sysinit' and before
script '/etc/rc.d/rc' which runs after USB  daemon khubd gets some signal
and ends. From this point USB does not work as as system does not get any
plug events. If I disable USB at startup and load modules later, everything
works.
     Under 2.4.x kernel everithing works as expected.


Petr Titera
petr.titera@whitesoft.cz


