Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131360AbRBHVrZ>; Thu, 8 Feb 2001 16:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131358AbRBHVrP>; Thu, 8 Feb 2001 16:47:15 -0500
Received: from cs.columbia.edu ([128.59.16.20]:54957 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131326AbRBHVrE>;
	Thu, 8 Feb 2001 16:47:04 -0500
Date: Thu, 8 Feb 2001 13:46:51 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jes@linuxcare.com>,
        Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A831313.A23EE2A1@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0102081346020.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Manfred Spraul wrote:

> What about changing the default for rx_copybreak instead?
> Set it to 1536 on ia64 and Alpha, 0 for the rest.
> tulip and eepro100 use that aproach.

That makes a lot of sense, thanks for the suggestion. I'll do so in the 
next version.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
