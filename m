Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423794AbWKPKw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423794AbWKPKw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423796AbWKPKwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:52:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32461 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423794AbWKPKwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:52:55 -0500
Date: Thu, 16 Nov 2006 10:53:11 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, linux@horizon.com
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Message-ID: <20061116105311.2f18b3d6@localhost.localdomain>
In-Reply-To: <20061116042432.26300.qmail@science.horizon.com>
References: <20061116042432.26300.qmail@science.horizon.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2006 23:24:32 -0500
linux@horizon.com wrote:

> Well, before giving up entirely, assume that *some* device owns that
> interrupt, it's just mis-routed.
> 
> So start calling the IRQ handlers for *every* PCI device until the
> damn interrupt goes away, or you've really proved that it can't
> be shut up.

See the "irqpoll" option. We don't however try and learn IRQ errors
from it although we certainly could do so (and indeed Ingo semi jokingly
suggested it when the patch went in)
