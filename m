Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276903AbRJHNwc>; Mon, 8 Oct 2001 09:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276897AbRJHNwW>; Mon, 8 Oct 2001 09:52:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:52201 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S276899AbRJHNwK>;
	Mon, 8 Oct 2001 09:52:10 -0400
Date: Mon, 8 Oct 2001 15:52:37 +0200
From: Sebastian Heidl <heidl@zib.de>
To: linux-kernel@vger.kernel.org
Subject: implementation of SIOCGIFFCOUNT
Message-ID: <20011008155237.C811@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-www.distributed.net: 9 OGR packets (1.10 Tnodes) [4.08 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

is there a specific reason for SIOCGIFCOUNT not being implemented
in  the kernel ? All occurences lead to net/core/dev.c dev_ioctl(...)
which just returns -EINVAL for this command. So one has to guess
the number of struct ifreq structures to pass to a SIOCGIFCONF
call.

enlighten me, please ;-)
_sh_

-- 
