Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWF2Pg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWF2Pg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWF2Pg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:36:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8400 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750805AbWF2PgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:36:25 -0400
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA
	from	Longhaul by rw semaphores
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: =?UTF-8?Q?Rafa=C5=82?= Bilski <rafalbilski@interia.pl>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <44A3C17F.3060204@etpmod.phys.tue.nl>
References: <44A2C9A7.6060703@interia.pl>
	 <1151581077.23785.9.camel@localhost.localdomain>
	 <44A3C17F.3060204@etpmod.phys.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 16:52:28 +0100
Message-Id: <1151596348.23785.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-29 am 14:03 +0200, ysgrifennodd Bart Hartgers:
> > "snooping". So we do need the cache sorting out.
> >
> 
> If I understand correctly, trouble occurs when the processor tries to
> snoop? Would disabling (via MSR) and flushing the caches before changing
> the frequency help in that case?

I would think so. Some other processors have similar requirements for
deep sleeping.

Alan

