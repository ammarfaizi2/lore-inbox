Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130880AbQKUTp4>; Tue, 21 Nov 2000 14:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131083AbQKUTpq>; Tue, 21 Nov 2000 14:45:46 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:36356 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130880AbQKUTpg>; Tue, 21 Nov 2000 14:45:36 -0500
Date: Tue, 21 Nov 2000 19:15:04 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Peter Samuelson <peter@cadcamlab.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0, test10, test11: HPT366 problem
In-Reply-To: <Pine.LNX.4.10.10011211030300.26689-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0011211914400.22252-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Andre Hedrick wrote:

> No, if it doesn not hang and we get iCRC errors it will down grade
> automatically, but it is a transfer rate issue than it must be hard coded
> to force an upper threshold limit.

Do we downgrade gracefully, or do we just drop directly to non-DMA mode?

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
