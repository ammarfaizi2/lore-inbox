Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRAURho>; Sun, 21 Jan 2001 12:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRAURhe>; Sun, 21 Jan 2001 12:37:34 -0500
Received: from quattro.sventech.com ([205.252.248.110]:42501 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130792AbRAURhc>; Sun, 21 Jan 2001 12:37:32 -0500
Date: Sun, 21 Jan 2001 12:37:31 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
Message-ID: <20010121123730.N9156@sventech.com>
In-Reply-To: <20010120130848.I9156@sventech.com> <200101202315.f0KNFTV01790@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <200101202315.f0KNFTV01790@flint.arm.linux.org.uk>; from Russell King on Sat, Jan 20, 2001 at 11:15:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001, Russell King <rmk@arm.linux.org.uk> wrote:
> Johannes Erdfelt writes:
> > They need to be visible via DMA. They need to be 16 byte aligned. We
> > also have QH's which have similar requirements, but we don't use as many
> > of them.
> 
> Can we get away from the "16 byte aligned" and make it "n byte aligned"?
> I believe that slab already has support for this?

If you look at the part of the message that I quoted and you cut off,
the requirements for UHCI are the data structures MUST be 16 byte aligned.

I don't mind if the API is more generalized, but those are the
requirements that were asked about in this specific case.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
