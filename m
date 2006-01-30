Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWA3BXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWA3BXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 20:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWA3BXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 20:23:43 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:34688 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751214AbWA3BXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 20:23:42 -0500
Date: Sun, 29 Jan 2006 23:23:42 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 0/4] - pktgen: refinements and small fixes (V2).
Message-ID: <20060129232342.1e481f9a@localhost>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi!

 I'm sending again the following patches for pktgen:

[PATCH 1/4]  pktgen: Lindent run.
[PATCH 2/4]  pktgen: Ports thread list to Kernel list implementation.
[PATCH 3/4]  pktgen: Fix kernel_thread() fail leak.
[PATCH 4/4]  pktgen: Fix Initialization fail leak.

 The changes from V1 are:

 1. More fixes made by hand after Lindent run
 2. Re-diffed agains't Dave's net-2.6.17 tree
 
  All the patches were tested with QEMU, emulating a machine with 4 CPUs
and 4 ethernet cards.

-- 
Luiz Fernando N. Capitulino
