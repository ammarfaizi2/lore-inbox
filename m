Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSLBPBV>; Mon, 2 Dec 2002 10:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSLBPBV>; Mon, 2 Dec 2002 10:01:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9630 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262670AbSLBPBU>; Mon, 2 Dec 2002 10:01:20 -0500
Subject: Re: ATAPI DMA timeouts showing up in logs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trog@wincom.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3deb629a.69c1.0@wincom.net>
References: <3deb629a.69c1.0@wincom.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 15:42:26 +0000
Message-Id: <1038843746.1000.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1970-01-01 at 05:59, Dennis Grant wrote:
> Now that I've got the proper IDE driver in place (2.4.20rc4) and the master drive
> on the primary interface is running at a full ATA133, these have started showing
> up in the logs - 2 or 3 a day:

My guess is its the IDE command/DMA sequence bug that Khalid fixed in
-ac. Some drives also take a very long time on retrying blocks and that
might cause a timeout/reset too.

> This last one is the only indication that something might be amiss - the two
> instances of "invalid argument" Other than that, the drive appears to work just
> fine.

Those are ones CD-ROM's dont support
