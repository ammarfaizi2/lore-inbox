Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313486AbSC2R3T>; Fri, 29 Mar 2002 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313487AbSC2R3P>; Fri, 29 Mar 2002 12:29:15 -0500
Received: from relay.publinet.it ([151.99.137.5]:57550 "EHLO relay.publinet.it")
	by vger.kernel.org with ESMTP id <S313486AbSC2R3A>;
	Fri, 29 Mar 2002 12:29:00 -0500
Date: Fri, 29 Mar 2002 18:28:54 +0100
From: Luca Maranzano <liuk@publinet.it>
To: arrays@compaq.com
Cc: linux-kernel@vger.kernel.org
Subject: Compaq Smart2 driver bug with Linux 2.4.18 and HIGHMEM ?
Message-ID: <20020329172854.GA28895@publinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: SIR s.r.l. - PublinetWork(tm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we've tryed to compile Linux Kernel 2.4.18 on a Compaq Proliant ML370 G2, 
Pentium III 1.13Ghz, 1GB RAM, 2x36.4GB HD and SCSI Controller Compaq Smart2 5i,
firmware version 1.80. The problem is that if we enable the
CONFIG_NOHIGHMEM to 4GB in order to enable full 1GB support, the kernel
will panic saying that it cannot correctly access the 
/dev/cciss/c0d0p1 root partition. Disabling the CONFIG_NOHIGHMEM support
all works fine.

Is this a known issue?

More info about our setup:

Debian 3.0
gcc version 2.95.4

Let me know if you need more info.

TIA.

Kind regards,
Luca



