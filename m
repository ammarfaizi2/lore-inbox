Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbTHTAGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTHTAGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:06:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59009 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261593AbTHTAGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:06:03 -0400
Date: Wed, 20 Aug 2003 01:05:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, jonsmirl@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: Standard driver call to enable/disable PCI ROM
Message-ID: <20030820000535.GD18035@mail.jlokier.co.uk>
References: <20030819210618.D23670@flint.arm.linux.org.uk> <20030819204643.75442.qmail@web14913.mail.yahoo.com> <20030819215246.H23670@flint.arm.linux.org.uk> <20030819141735.52ffedc7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819141735.52ffedc7.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 19 Aug 2003 21:52:46 +0100
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> >                 new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
> >                 reg = dev->rom_base_reg;
> 
> A word of caution, please do not enable PCI ROMs lightly.
> 
> There are many devices which stop responding to MEM and IO
> space once their ROM is enabled, Qlogic-ISP chips are one
> such device and there are several others.

I take it the devices do respond to MEM and IO after the ROM is
disabled again?

-- Jamie

