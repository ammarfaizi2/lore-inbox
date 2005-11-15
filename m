Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVKOASE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKOASE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVKOASE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:18:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:51329 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932259AbVKOASD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:18:03 -0500
Subject: Re: [PATCH 2 of 2] tpm: updates for new hardware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Kylene Jo Hall <kjhall@us.ibm.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jake Moilanen <moilanen@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>
In-Reply-To: <200511141710.41230.bjorn.helgaas@hp.com>
References: <1131739595.5048.15.camel@localhost.localdomain>
	 <200511141710.41230.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 11:17:07 +1100
Message-Id: <1132013827.6094.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why don't you use ioread8() instead of defining atmel_getb()?
> 
> You'd still need something PPC64-specific to initialize the iomem cookie,
> but the accessors would go away.
> 
> Unfortunately, ioread8() and associated interfaces aren't mentioned
> under Documentation/, but there are some hints in lib/iomap.c.

Yes, I was about to reply the same thing :)

Ben.


