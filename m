Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWBYTHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWBYTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBYTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:07:09 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:64910 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161062AbWBYTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:07:07 -0500
Date: Sat, 25 Feb 2006 16:07:34 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 0/6] pktgen: refinements and small fixes (V3).
Message-ID: <20060225160734.020bba3b@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi David,

 As you've asked, I'm sending again my patches for pktgen:

[PATCH 1/6] pktgen: Lindent run.
[PATCH 2/6] pktgen: Ports thread list to Kernel list implementation.
[PATCH 3/6] pktgen: Fix kernel_thread() fail leak.
[PATCH 4/6] pktgen: Fix Initialization fail leak.
[PATCH 5/6] pktgen: Ports if_list to the in-kernel implementation.
[PATCH 6/6] pktgen: Updates version.

 The changes from V2 are:

 1. Generated all the patches again agaisnt current net-2.6.17 tree
 2. Added the if_list port patch to the series, because it was sent
 separately last time
 3. Added a patch to updates pktgen's version (forgot this one first
 time).

 As I did before, all the patches were tested with QEMU emulating a four
CPU machine with four NICS.

 Also note that Robert have already acked patches 1 to 4.

 Thanks,

-- 
Luiz Fernando N. Capitulino
