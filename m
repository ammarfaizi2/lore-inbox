Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270640AbRIJLZQ>; Mon, 10 Sep 2001 07:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270585AbRIJLZG>; Mon, 10 Sep 2001 07:25:06 -0400
Received: from frank.gwc.org.uk ([212.240.16.7]:37647 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S270640AbRIJLY4>;
	Mon, 10 Sep 2001 07:24:56 -0400
Date: Mon, 10 Sep 2001 12:25:15 +0100 (BST)
From: Alistair Riddell <ali@gwc.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: New SCSI subsystem in 2.4, and scsi idle patch
In-Reply-To: <200109092229.f89MT3M07627@smtp-server2.tampabay.rr.com>
Message-ID: <Pine.LNX.4.21.0109101216030.14338-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Phillip Susi wrote:

> I'm trying to get my 2.4.9 system to spin down my scsi disk(s) when idle.  
> Aparently, this is supported on IDE disks, but not SCSI.  I found an old 

AFAIK, the spinning down of IDE disks is done by the disks themselves
rather than by the kernel. The software support consists of a method to
tell the disk controller what idle period to wait before spinning down.

I don't know whether SCSI disks have a similar feature. But if they did it
would be easier to make use of that than to implemement a software
timer...

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 447 7931 Ext 176       Fax: +44 131 452 8594
Microsoft - because god hates us

