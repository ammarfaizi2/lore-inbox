Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270522AbTGSUXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270526AbTGSUXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:23:19 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:11394 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id S270522AbTGSUXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:23:18 -0400
Date: Sat, 19 Jul 2003 22:41:03 +0200
Message-ID: <vines.sxdD+TnO4zA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: alpha; gas & linux 2.6.0-test1
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi list,
i tried to compile linux 2.6.0 unfortunaly the
GNU assembler version 2.11.90.0.8 (alpha-redhat-linux) using BFD version 2.11.90.0.8
has a problem:

  AS      usr/initramfs_data.o
usr/initramfs_data.S: Assembler messages:
usr/initramfs_data.S:2: Error: Unknown pseudo-op:  `.incbin'
make[1]: *** [usr/initramfs_data.o] Fehler 1

I solved that with an upgrade to
GNU assembler version 2.13 (alphaev56-unknown-linux-gnu) using BFD version 2.13

there is already a check for as < 2.7 perhaps checking for <2.13 would be better :)

walter
