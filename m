Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRB1VPG>; Wed, 28 Feb 2001 16:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRB1VO5>; Wed, 28 Feb 2001 16:14:57 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:22791 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129216AbRB1VOw>;
	Wed, 28 Feb 2001 16:14:52 -0500
Date: Wed, 28 Feb 2001 16:14:50 -0500
From: Zach Brown <zab@zabbo.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_dma_set_mask()
Message-ID: <20010228161450.A25553@tetsuo.zabbo.net>
In-Reply-To: <20010228103727.I23735@tetsuo.zabbo.net> <3A9D26A2.14563DE1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A9D26A2.14563DE1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 28, 2001 at 11:26:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pci_dma_supported has a boolean return, but the kernel norm is to return
> zero on success, and -EFOO on error.  I like your proposal with the

*nod*  I just followed pci_dma_supported().

> extremely minor nit that I think pci_set_dma_mask should return ENODEV
> or EIO or something on error, and zero on success.

I agree, though I'd like to leave the decision up to people who live and
breathe this stuff.

please feel free to make minor adjustments and submit :)

- z
