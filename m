Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293748AbSCAUtU>; Fri, 1 Mar 2002 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293747AbSCAUtL>; Fri, 1 Mar 2002 15:49:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62474 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293748AbSCAUtF>; Fri, 1 Mar 2002 15:49:05 -0500
Subject: Re: queue_nr_requests needs to be selective
To: akpm@zip.com.au (Andrew Morton)
Date: Fri, 1 Mar 2002 21:03:22 +0000 (GMT)
Cc: jmerkey@vger.timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
In-Reply-To: <3C7FE7DD.98121E87@zip.com.au> from "Andrew Morton" at Mar 01, 2002 12:43:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16guBW-00051l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't immediately see why increasing the queue length should
> increase bandwidth in this manner.  One possibility is that

Latency on the controllers ?  With caches on the controller and disks you
can have a lot of requests actually in flight

