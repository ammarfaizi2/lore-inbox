Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSANJXM>; Mon, 14 Jan 2002 04:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288780AbSANJXC>; Mon, 14 Jan 2002 04:23:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31760 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288752AbSANJW7>; Mon, 14 Jan 2002 04:22:59 -0500
Subject: Re: Oops in kswapd (Kernel 2.4.17)
To: patrickb@vrlaw.com.au (Patrick Burns)
Date: Mon, 14 Jan 2002 09:34:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C423A90.2E34D426@vrlaw.com.au> from "Patrick Burns" at Jan 14, 2002 12:55:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q3Vs-00019y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that people were getting oopses in kswapd. I also had the same problem
> this morning. The kernel froze up totally. Not even SysRq keys would
> work. I am running 2x400mhz PII in an SMP machine with 512mb RAM. I have
> attatched the syslog of the oops and what I got when I ran it past

With 2.4.17 apply Ben LaHaise's LRU patch posted to the kernel list or
grab 2.4.18pre3. I saw all sorts of interesting occssional oopses without
that. It might not be the problem you see but its showing up so much that
its worth checking first
