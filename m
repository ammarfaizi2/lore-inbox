Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRCJBQo>; Fri, 9 Mar 2001 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130800AbRCJBQX>; Fri, 9 Mar 2001 20:16:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56070 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130792AbRCJBQW>; Fri, 9 Mar 2001 20:16:22 -0500
Subject: Re: [PATCH]: allow notsc option for buggy cpus
To: anton@linuxcare.com.au (Anton Blanchard)
Date: Sat, 10 Mar 2001 01:19:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20010310115828.A7514@linuxcare.com> from "Anton Blanchard" at Mar 10, 2001 11:58:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bY2D-00063q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My IBM Thinkpad 600E changes between 100MHz and 400MHz depending if the
> power is on. This means gettimeofday goes backwards if you boot with the

Intel speedstep CPU. 

> Even so, we should really catch these cpus at run time. 

Intel are being remarkably reluctant on the documentation front.  We have
the AMD speed change docs, but the intel ones (chipset not cpu based
primarily) don't seem to be publically available. In fact the 815M manual
looks like someone quite pointedly went through and removed the relevant
material before publication

