Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130900AbQKZTD4>; Sun, 26 Nov 2000 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132240AbQKZTDq>; Sun, 26 Nov 2000 14:03:46 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:60676 "EHLO
        imladris.demon.co.uk") by vger.kernel.org with ESMTP
        id <S130900AbQKZTDh>; Sun, 26 Nov 2000 14:03:37 -0500
Date: Sun, 26 Nov 2000 18:33:23 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test11: Trying to free nonexistent resource <000003e0-000003e1>
In-Reply-To: <20001126011224.B10587@iapetus.localdomain>
Message-ID: <Pine.LNX.4.30.0011261830210.13161-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Frank van Maarseveen wrote:

> Nov 25 23:15:12 mimas cardmgr[342]: exiting
> Nov 25 23:15:14 mimas kernel: Trying to free nonexistent resource <000003e0-000003e1>
> Nov 25 23:15:14 mimas kernel: unloading PCMCIA Card Services

This is normal behaviour. It's buggy but it's harmless. It'll go away when
the i82365 driver is rewritten in 2.5.

On which subject - anyone who has, or can get, a datasheet for the Intel
82092AA PCI-PCMCIA bridge, please drop me a line.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
