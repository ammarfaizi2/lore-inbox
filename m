Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbQKFH37>; Mon, 6 Nov 2000 02:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129872AbQKFH3t>; Mon, 6 Nov 2000 02:29:49 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:34310 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129036AbQKFH3j>; Mon, 6 Nov 2000 02:29:39 -0500
Date: Mon, 6 Nov 2000 07:29:22 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <3A065CDD.BF15B3AC@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011060727540.14068-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Jeff Garzik wrote:

> Linux-Mandrake's initscripts run aumix on bootup and shutdown, to take
> care of this...

So does Red Hat. You can also have a post-install script which does it
after a module is auto-loaded. There can still be a number of seconds
between the initialisation of the hardware and the desired mixer levels
actually getting set.


-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
