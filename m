Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268855AbTBZSbI>; Wed, 26 Feb 2003 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbTBZSbI>; Wed, 26 Feb 2003 13:31:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4235
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268855AbTBZSbH>; Wed, 26 Feb 2003 13:31:07 -0500
Subject: Re: Question about DMA and cd burning.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: jpiszcz <jpiszcz@lucidpixels.com>, vishwas@india.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030226115335.4300A-100000@chaos>
References: <Pine.LNX.3.95.1030226115335.4300A-100000@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046288332.9834.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 19:38:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 17:02, Richard B. Johnson wrote:
> This has turned out to be a FAQ.  DMA is not "better"
> than some other transfer mode.  It's just a method.

In the IDE world that isnt quite so. The IDE world has other
limits depending on PIO versus DMA setup which make your
explanation, while correct for the general case incorrect for
the IDE world.

DMA is a lot better than other transfer modes on IDE devices, not
only because PIO burns CPU but because of the cable timings.
IDE normally goes up to PIO4, PIO4 is equivalent to MWDMA2. IDE
DMA then goes up to UDMA133/150 with SATA. So PIO limits you to
a fair bit under 10Mbytes/second, while UDMA133 generally comes
down to your PCI bus capability. 



