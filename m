Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSGMOTr>; Sat, 13 Jul 2002 10:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSGMOTr>; Sat, 13 Jul 2002 10:19:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17391 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313711AbSGMOTp>; Sat, 13 Jul 2002 10:19:45 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207130840080.7697-100000@dad.molina>
References: <Pine.LNX.4.44.0207130840080.7697-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 16:31:35 +0100
Message-Id: <1026574295.13885.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 14:55, Thomas Molina wrote:
> > So we'd have a legacy driver called oh say 'ide-cd' and a current one
> > called 'ide-scsi'.
> > 
> > How does that change anything ?
> 
> It gives us the possibility to create a "clean" design for modern hardware 
> while maintaining support for "legacy" hardware.  You don't have to carry 
> around a lot of special cases and distort the design to take into account 

You missed the point. We -ALREADY- have ide-cd and ide-scsi. We already
do what is described, and in fact Martin and co want to remove that
seperation and stuff the gunge into the general atapi layer

