Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbREQVW4>; Thu, 17 May 2001 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbREQVWq>; Thu, 17 May 2001 17:22:46 -0400
Received: from [24.219.123.215] ([24.219.123.215]:35332 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262183AbREQVWg>; Thu, 17 May 2001 17:22:36 -0400
Date: Thu, 17 May 2001 14:22:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernel Archive: ATA overlap/queuing support ?
In-Reply-To: <3B043FA1.D45D3B2B@linux-ide.org>
Message-ID: <Pine.LNX.4.10.10105171417550.2341-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there support in linux for ATA overlap/queuing ?

It should ( among other things ) improve concurent performance
of two devices on the same channel.

--
David Balazic
--------------

> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.2/0022.html

No, queuing is broken and requires a special host to do the auto-polling.
Right now only HighPoint has a host that will perform that operation.

Also it requires TFAM and that will not be include until 2.5.

ATA-overlap or ATAPI-overlap?  The later is known as DSC based on
SFF-8020/8070/8090, I have forgotten where it is located but I have the
docs, and it is supported in ide-floppy and ide-tape.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

