Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271416AbTG2MMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTG2MMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:12:30 -0400
Received: from dialpool-210-214-80-4.maa.sify.net ([210.214.80.4]:21895 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271416AbTG2MMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:12:16 -0400
Date: Tue, 29 Jul 2003 17:43:26 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729121326.GA3258@localhost.localdomain>
References: <20030728225947.GA1694@localhost.localdomain> <20030729014822.6488539d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729014822.6488539d.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to copy the 4.9 GB file from the _local_ computer back to the server, it copies 2.1 GB of the file and quits. This is what strace says:

write(4, "8", 1)                        = -1 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) @ 0 (0) ---
+++ killed by SIGXFSZ +++

Is this normal? Haven't tried with 2.4.20 yet...
