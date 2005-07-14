Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVGNXKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVGNXKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVGNXKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:10:35 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:52912 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262639AbVGNXIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:08:44 -0400
Date: Fri, 15 Jul 2005 03:08:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050715030847.D613@den.park.msu.ru>
References: <20050714155344.A27478@jurassic.park.msu.ru> <20050714145327.B7314@flint.arm.linux.org.uk> <9e47339105071407073f07bed7@mail.gmail.com> <20050715014611.B613@den.park.msu.ru> <9e47339105071415392ef2eb2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9e47339105071415392ef2eb2e@mail.gmail.com>; from jonsmirl@gmail.com on Thu, Jul 14, 2005 at 06:39:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 06:39:43PM -0400, Jon Smirl wrote:
> I had the wrong define, this is the one I was thinking of IORESOURCE_BUS_HAS_VGA

Oh, I definitely agree about that one. It's been unused for a couple of
years, at least. Let's kill it, please.

Ivan.
