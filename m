Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbQKDRfQ>; Sat, 4 Nov 2000 12:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129357AbQKDRfG>; Sat, 4 Nov 2000 12:35:06 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:7948 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129321AbQKDRex>; Sat, 4 Nov 2000 12:34:53 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA25698D.00608C13.00@d73mta05.au.ibm.com>
Date: Sat, 4 Nov 2000 19:27:58 +0530
Subject: processes> 2^15
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
after reaching process count something around 30568, processes start
getting pid from start, which ever is the first free entry slot in process
table. that means we can't have simultaneously more than roughly 2^15
processes?
am i correct?

regards,
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
