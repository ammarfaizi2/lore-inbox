Return-Path: <linux-kernel-owner+w=401wt.eu-S1751666AbWLMXsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWLMXsC (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWLMXsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:48:01 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48768 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751663AbWLMXsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:48:00 -0500
Date: Wed, 13 Dec 2006 23:56:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: tglx@linutronix.de
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061213235601.2a565229@localhost.localdomain>
In-Reply-To: <1166049055.29505.47.camel@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	<Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	<1166044471.11914.195.camel@localhost.localdomain>
	<Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	<1166048081.11914.208.camel@localhost.localdomain>
	<1166049055.29505.47.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 23:30:55 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> - IRQ happens
> - kernel handler runs and masks the chip irq, which removes the IRQ
> request

IRQ is shared with the disk driver, box dead. Plus if this is like the
uio crap in -mm its full of security holes.
