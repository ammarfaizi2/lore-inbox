Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBLKre>; Mon, 12 Feb 2001 05:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbRBLKrY>; Mon, 12 Feb 2001 05:47:24 -0500
Received: from cs.columbia.edu ([128.59.16.20]:956 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129047AbRBLKrO>;
	Mon, 12 Feb 2001 05:47:14 -0500
Date: Mon, 12 Feb 2001 02:47:12 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new version of the starfire driver for 2.2.19pre
In-Reply-To: <E14SFss-0006Zw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102120245310.4687-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Alan Cox wrote:

> No resolution to firmware fiasco, no driver in kernel

But the driver _does_ work without the firmware, it only loses the
hardware TCP checksum on Rx capability. That's what we have in 2.4.x right 
now, why should 2.2.x be pickier and *demand* to have the firmware or no 
support at all?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
