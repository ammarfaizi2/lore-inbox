Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbSJBAkN>; Tue, 1 Oct 2002 20:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261870AbSJBAkN>; Tue, 1 Oct 2002 20:40:13 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:18423 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261685AbSJBAkM>; Tue, 1 Oct 2002 20:40:12 -0400
Subject: Re: sl82c105 and icside.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@math.psu.edu>, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20021001202519.C5092@flint.arm.linux.org.uk>
References: <20021001202519.C5092@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 01:51:07 +0100
Message-Id: <1033519867.20103.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-01 at 20:25, Russell King wrote:
> I'd prefer these drivers to lag behind and I'll pick up the changes OR
> copy me on the changes to these files please.  I don't mind which.

Its much harder for me not to propogate stuff to one specific driver.
I'd much rather you simply ignored the new driver if this is a problem
then resync when ready.

> For the present, I've now got to work out exactly what changed between
> .34 and .40 and apply those changes to some completely different versions
> of these drivers.

Your best bet is probably to look at the diff between 2.4.19 and
2.4.20pre8-ac in terms of changes to the drivers themselves. The file
moving means you want to diff the two by hand but the changes should be
clear enough. If not drop me a note

