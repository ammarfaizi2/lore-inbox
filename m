Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSK1QAy>; Thu, 28 Nov 2002 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbSK1QAy>; Thu, 28 Nov 2002 11:00:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:11415 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264637AbSK1QAy>; Thu, 28 Nov 2002 11:00:54 -0500
Subject: Re: how to list pci devices from userpace?  anything better than
	/proc/bus/pci/devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021127163510.4690A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021127163510.4690A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 16:37:55 +0000
Message-Id: <1038501475.10020.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 21:41, Richard B. Johnson wrote:
> Red Hat distributions after 7.0 provide `lspci`. You still have
> to parse ASCII. FYI, it's not hard to write a 'C' program
> that directly accessed the PCI bus from its ports at 0xCF8 (index)
> and 0xCFC (data). You need to do 32-bit port accesses and you
> can set iopl(3) from user-space.

That wont work portably. lspci comes with a pci access library that uses
the kernel interfaces and does the job correctly

