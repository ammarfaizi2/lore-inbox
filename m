Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUH2P5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUH2P5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUH2P5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:57:30 -0400
Received: from gepard.lm.pl ([212.244.46.42]:53956 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S267998AbUH2P53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:57:29 -0400
Subject: 2.6.9-rc1-mm1 kjournald: page allocation failure. order:1,
	mode:0x20
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: o2.pl Sp z o.o.
Message-Id: <1093794970.1751.10.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Aug 2004 17:56:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after creating several GB of data in small files on the SMP highmem box
the

kjournald: page allocation failure. order:1, mode:0x20


start flooding the logs, load goes to sth around 1k, writing processes
get stuck in D state and the system needs hard reset.

Anyone else is experiencing that kind of problems?

Im running sw raid1 on that box, not preemtible kernel.


Krzysztof

