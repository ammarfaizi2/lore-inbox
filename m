Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRBIUH6>; Fri, 9 Feb 2001 15:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRBIUHs>; Fri, 9 Feb 2001 15:07:48 -0500
Received: from cs.columbia.edu ([128.59.16.20]:56227 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129143AbRBIUHl>;
	Fri, 9 Feb 2001 15:07:41 -0500
Date: Fri, 9 Feb 2001 12:07:35 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jes@linuxcare.com>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A844022.CF971105@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0102091204560.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Jeff Garzik wrote:

> I would prefer that zerocopy code remain out of all official kernels
> until zerocopy itself is in said kernels.  It's experimental code that
> simply cannot work in its present form, due to lack of infrastructure in
> the general kernel.  And being based on experimental code itself, there
> is definitely the potential for changes yet.

Fine.

> BTW, I would suggest looking at Jes' acenic.c as an example of a 2.4
> driver that is clean but also [hopefully!] works under 2.2.

The *only* thing I couldn't solve cleanly is the MOD_{INC,DEC}_USE_COUNT 
vs MODULE_SET_OWNER(). And I would really appreciate pointers for that. :)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
