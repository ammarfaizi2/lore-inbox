Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRCFHMn>; Tue, 6 Mar 2001 02:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRCFHMd>; Tue, 6 Mar 2001 02:12:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:41227
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129306AbRCFHMT>; Tue, 6 Mar 2001 02:12:19 -0500
Date: Mon, 5 Mar 2001 23:12:05 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's  
In-Reply-To: <Pine.LNX.4.10.10103052136580.1011-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10103052310080.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Linus Torvalds wrote:

> Well, it's fairly hard for the kernel to do much about that - it's almost
> certainly just IDE doing write buffering on the disk itself. No OS
> involved.

I am pushing for WC to be defaulted in the off state, but as you know I
have a bigger fight than caching on my hands...

> I don't know if there is any way to turn of a write buffer on an IDE disk.

You want a forced set of commands to kill caching at init?

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

