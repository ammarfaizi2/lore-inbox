Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVHVAKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVHVAKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHVAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 20:10:40 -0400
Received: from [81.2.110.250] ([81.2.110.250]:11246 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751196AbVHVAKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 20:10:40 -0400
Subject: Re: IRQ problem with PCMCIA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: "Hesse, Christian" <mail@earthworm.de>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
In-Reply-To: <20050821221935.GB18925@sonic.net>
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net>  <20050821221935.GB18925@sonic.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Aug 2005 01:38:02 +0100
Message-Id: <1124671082.1101.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-21 at 15:19 -0700, David Hinds wrote
> One caveat: I'm not sure if CardBus IDE devices are working under
> Linux??  I'd think they should work with 2.6, but don't actually know
> that for a fact.

They work with some patches to the core IDE code I did, but I've given
up ever getting those into the kernel. Please wait instead for the new
SATA/ATA layer to develop hotplug support.

