Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRDQOcq>; Tue, 17 Apr 2001 10:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132684AbRDQOcg>; Tue, 17 Apr 2001 10:32:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61966 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132664AbRDQOcZ>; Tue, 17 Apr 2001 10:32:25 -0400
Subject: Re: DPT PM3755F Fibrechannel Host Adapter
To: cacook@freedom.net
Date: Tue, 17 Apr 2001 15:34:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417130019Z132595-682+791@vger.kernel.org> from "cacook@freedom.net" at Apr 17, 2001 06:58:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pWYl-0002SB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Applying the patch & compiling went fine.  But the new kernel doesn't recognize the FC host adapter (though the bios does) and there is no dpt_i20 module so I can't insmod.  I don't know how to tell whether the driver is in the kernel.  Maybe I'm just not smart enough for Linux.
> 

No its not your fault. The dpt_i2o stuff depends on a driver that isnt in the
standard kernels, doesn't work for all cases. Im still trying to get a driver
out of them good enough to merge but its an incredibly slow tedious process.

For actual work I'm using symbios fibrechannel cards and most people I know
use qlogic cards with Linux. 

Alan

