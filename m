Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNMyk>; Wed, 14 Feb 2001 07:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRBNMyb>; Wed, 14 Feb 2001 07:54:31 -0500
Received: from cs.columbia.edu ([128.59.16.20]:64992 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129055AbRBNMyP>;
	Wed, 14 Feb 2001 07:54:15 -0500
Date: Wed, 14 Feb 2001 04:54:09 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>, Donald Becker <becker@scyld.com>,
        Jes Sorensen <jes@linuxcare.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device
In-Reply-To: <Pine.LNX.3.96.1010214064743.13194A-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0102140452140.14404-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Jeff Garzik wrote:

> On Wed, 14 Feb 2001, Alan Cox wrote:
> > It does. It does so on IA64 now as well. The only architecture which has troubles
> > with alignment on IP frames now is ARM2
> 
> So the IA64-specific PKT_CAN_COPY code in starfire can go away
> completely?  Jes, can you test such w/ the latest kernel and starfire,
> less your IA64-specific code?

The way I understand it, IA64 and Alpha cope with it, but at the expense 
of taking an exception for each packet -- so it's not worth it.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

