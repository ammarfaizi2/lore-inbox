Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133069AbRDLInz>; Thu, 12 Apr 2001 04:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133074AbRDLInp>; Thu, 12 Apr 2001 04:43:45 -0400
Received: from mta02-acc.tin.it ([212.216.176.33]:28880 "EHLO fep02-svc.tin.it")
	by vger.kernel.org with ESMTP id <S133069AbRDLInZ> convert rfc822-to-8bit;
	Thu, 12 Apr 2001 04:43:25 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
From: lomarcan@tin.it
Reply-To: lomarcan@tin.it
Subject: SCSI Tape Corruption - update
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010412084318.LESP2878.fep02-svc.tin.it@fep41-svc.tin.it>
Date: Thu, 12 Apr 2001 10:43:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still experimenting with my SDT-9000... tried connecting it to another
controller
(2940AU in place of 2904, sorry but I've only Adaptec stuff :). Same
problem.
Tried with another tape (even with an old DDS-2 tape). Same. Even tried
another
cable/removing the CDWR drive from the bus.

It seems that the tape is written incorrectly. I wrote some large file
(300MB)
and read it back four time. The read copies are all the same. They differ
from the original only in 32 consecutive bytes (the replaced values SEEM
random). Of course, 32 bytes in 300MB tar.gz files are TOO MUCH to be 
accepted :)

Now I'll build some old 2.2 kernel to try...

				-- Lorenzo Marcantonio

