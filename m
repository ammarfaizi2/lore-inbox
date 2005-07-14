Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVGNXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGNXdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVGNXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:33:17 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:54704 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261761AbVGNXdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:33:16 -0400
Date: Fri, 15 Jul 2005 03:33:21 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050715033321.E613@den.park.msu.ru>
References: <20050714155344.A27478@jurassic.park.msu.ru> <20050714145327.B7314@flint.arm.linux.org.uk> <20050715014436.A613@den.park.msu.ru> <9e47339105071415423caabe8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9e47339105071415423caabe8d@mail.gmail.com>; from jonsmirl@gmail.com on Thu, Jul 14, 2005 at 06:42:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 06:42:30PM -0400, Jon Smirl wrote:
> You need to take this code into account, from arch/i386/pci/fixup.c

Yes, I've seen that (nice code, btw :-). But my code snippet has
nothing to do with x86 or any particular architecture - it just
shows that some hypothetical platform that doesn't have working
PCI firmware won't be hurt heavily by that patch. ;-)

Ivan.
