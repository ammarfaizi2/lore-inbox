Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQKVBmY>; Tue, 21 Nov 2000 20:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132097AbQKVBmS>; Tue, 21 Nov 2000 20:42:18 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:22028
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130989AbQKVBmA>; Tue, 21 Nov 2000 20:42:00 -0500
Date: Tue, 21 Nov 2000 17:11:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Peter Samuelson <peter@cadcamlab.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem
In-Reply-To: <Pine.LNX.4.30.0011211914400.22252-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10011211710200.29032-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, David Woodhouse wrote:

> On Tue, 21 Nov 2000, Andre Hedrick wrote:
> 
> > No, if it doesn not hang and we get iCRC errors it will down grade
> > automatically, but it is a transfer rate issue than it must be hard coded
> > to force an upper threshold limit.
> 
> Do we downgrade gracefully, or do we just drop directly to non-DMA mode?

With Grace, and now you blessed, go in peace my son.

grep crc ./drivers/ide/*

Cheers,


Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
