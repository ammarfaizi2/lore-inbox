Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSIQKlC>; Tue, 17 Sep 2002 06:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264042AbSIQKlC>; Tue, 17 Sep 2002 06:41:02 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:10229
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264037AbSIQKlB>; Tue, 17 Sep 2002 06:41:01 -0400
Subject: Re: DMA finally works! Thanks!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Rob Speer <rspeer@MIT.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209170047430.11597-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10209170047430.11597-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Sep 2002 11:48:25 +0100
Message-Id: <1032259705.13990.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 08:48, Andre Hedrick wrote:
> On Tue, 17 Sep 2002, Rob Speer wrote:
> 
> > Now that I'm using -pre7, DMA finally works on my Intel 845G controller
> > that was being such a pain in the ass.
> > 
> > Someone out there, possibly Andre, rules. Great work.
> 
> I did not touch -pre7 directly, maybe Alan Cox filtered some goodies.

I filtered out the PCI changes and the pci_enable_bars code. So its my
work, but Andre's explanations about what we should be doing

