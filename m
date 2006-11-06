Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753833AbWKFVeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbWKFVeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbWKFVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:34:00 -0500
Received: from kilderkin.sout.netline.net.uk ([213.40.66.40]:4554 "EHLO
	kilderkin.sout.netline.net.uk") by vger.kernel.org with ESMTP
	id S1753833AbWKFVeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:34:00 -0500
Message-ID: <454FAA44.1080000@supanet.com>
Date: Mon, 06 Nov 2006 21:33:56 +0000
From: Andrew Benton <b3nt@supanet.com>
User-Agent: Thunderbird 3.0a1 (X11/20061019)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.19 Microcode Update causes a ten second wait
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Supanet-AV-out: Mail Scanned as virus free, although you should still use a local virus scanner.
X-Supanet: This was sent via a www.supanet.com mail server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World
With the 2.6.19 kernels I've tried (2.6.19-rc1-git7 and 
2.6.19-rc4-git10), enabling the Intel Microcode Update Driver causes the 
kernel to hang for more than ten seconds when I boot. The last thing it 
shows on the screen is `TCP reno registered' and then it just stops like 
its a kernel panic. But it isn't, after about ten seconds the text flies 
up the screen again and the system boots normally. Disabling support for 
the microcode update makes the problem go away.

Andy
