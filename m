Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbTAEB14>; Sat, 4 Jan 2003 20:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbTAEB14>; Sat, 4 Jan 2003 20:27:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31106
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262392AbTAEB14>; Sat, 4 Jan 2003 20:27:56 -0500
Subject: Re: Can IDE work efficiently _without_ an IRQ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michal Kochanowicz <michal@michal.waw.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030105011708.GA20748@woland.michal.waw.pl>
References: <20030105011708.GA20748@woland.michal.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041733218.2555.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Jan 2003 02:20:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 01:17, Michal Kochanowicz wrote:
> After some hardware upgrade (2x more RAM, new motherboard with ~3x
> faster CPU) I found out that performance of HDD degraded heavilly.
> Looking for the reason I found out that kernel is unable to assign IRQ
> to IDE controller:

It has an IRQ  - it is in compatibility mode. Unfortunately some of the
pci_enable_device stuff seems intent on printing misleading messages
when the device gets enabled. 



