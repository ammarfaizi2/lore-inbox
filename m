Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSLCPgV>; Tue, 3 Dec 2002 10:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLCPgV>; Tue, 3 Dec 2002 10:36:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64672 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261593AbSLCPgU>; Tue, 3 Dec 2002 10:36:20 -0500
Subject: Re: [2.5.50 NCR5380/PAS16] bad: scheduling while atomic!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul <set@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021203013938.GO1432@squish.home.loc>
References: <20021203013938.GO1432@squish.home.loc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 16:17:51 +0000
Message-Id: <1038932271.11439.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 01:39, Paul wrote:
> 	Hi;
> 
> 	This happens just before the scsi cdrom would be detected
> during boot. The bad: part and the call trace are endlessly
> emited (exact same trace) and its pretty much game over.
> (fortunately I had a serial console machine handy.)
> 	The driver is compiled into the kernel, not a module.
> 	The card (pas16) works under 2.4. I can test things
> or supply more information/debugging if anyone wants.

Im using generic 5380 on 2.5.x but not 2.5.50 yet. Can you turn on all
the NCR5380 debugging and see where it errors from (the trace doesnt
give an answer as gcc has been smartly inlining functions used in one
place only I suspect)

