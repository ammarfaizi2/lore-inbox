Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSHHMAe>; Thu, 8 Aug 2002 08:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSHHMAe>; Thu, 8 Aug 2002 08:00:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58606 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317488AbSHHMAd>; Thu, 8 Aug 2002 08:00:33 -0400
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Ingo Molnar <mingo@elte.hu>, "Adam J. Richter" <adam@yggdrasil.com>,
       Andries.Brouwer@cwi.nl, johninsd@san.rr.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D525489.3050209@evision.ag>
References: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>	
	<3D523B25.5080105@evision.ag>
	<1028809830.28883.13.camel@irongate.swansea.linux.org.uk> 
	<3D525489.3050209@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 14:23:53 +0100
Message-Id: <1028813033.28882.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 12:22, Marcin Dalecki wrote:
> 1. Requiring the kernel to read the partition table information is a
> BUG.

We read it anyway to read the partitions for the block layer. 

> 2. Falling back on the values which are used by the application 
> afterwards is a BUG. (BIOS IRQ after all)

Breaking code is not a bug

> 3. Not detecting LBA disk access is required by checking Cylinder value
> to emulate BIOS behaviour is a BUG.

So why did you take it out ?


Thank you for reminding me why I've given up on the 2.5 kernel ever
working. Fortunately free software is self correcting so the tree can be
forked into something workable

