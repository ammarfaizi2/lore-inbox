Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSITSOZ>; Fri, 20 Sep 2002 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSITSOZ>; Fri, 20 Sep 2002 14:14:25 -0400
Received: from ns.ithnet.com ([217.64.64.10]:6148 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263232AbSITSOY>;
	Fri, 20 Sep 2002 14:14:24 -0400
Date: Fri, 20 Sep 2002 20:19:19 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19, 2.4.20pre7, problem with aic7xxx driver
Message-Id: <20020920201919.3009507f.skraw@ithnet.com>
In-Reply-To: <1184680000.1032536231@aslan.scsiguy.com>
References: <20020920052832.GH41965@niksula.cs.hut.fi>
	<1184680000.1032536231@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Justin, hello all,

I just came across an interesting phenomenon regarding 2.4.19 / 2.4.20-pre7 and
adaptec scsi. Scene is this:

board: Asus SP97-V with Pentium 200 (non-MMX) (I know it is old)
controllers tried: adaptec 29160, 29160N, 2940 U2W
kernel: 2.4.18-SuSE (distribution 8.0), 2.4.19, 2.4.20-pre7

>From all possible configurations of the above the following work:

kernel 2.4.18-SuSE: with all controllers
kernel 2.4.19     : only with 2940 U2W
kernel 2.4.20-pre7: only with 2040 U2W

All other configurations with newer adaptecs and recent kernels fail during
init of controller. Last message in sight: "PCI: Sharing interrupt xxx"

I tried all interrupts from 5-14 and configurations with other pci devices
plugged in or not. The problem stays the same.
I really wonder what they did to 2.4.18 so that this one works... ??
Any suggestions?

Regards,
Stephan


