Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWIKOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWIKOik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWIKOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:38:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63165 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751259AbWIKOij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:38:39 -0400
Subject: Re: PATCH: Fix 2.6.18-rc6 IDE breakage, add missing ident needed
	for	current VIA boards
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <45056544.8070303@pobox.com>
References: <1157982307.23085.140.camel@localhost.localdomain>
	 <45056544.8070303@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 15:59:24 +0100
Message-Id: <1157986765.23085.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 09:31 -0400, ysgrifennodd Jeff Garzik:
> For the first:
> * just add the missing zeroes.  No need to revert PCI_DEVICE() usage.

Safer to revert thats all

> For the second:
> * the sata_via PCI ID has been queued for 2.6.19 for quite a while.  I 
> don't see a hugely pressing need for it to be in 2.6.18, but it's not a 
> big deal to me.

Many of the current VIA mainboards have that ID so I would say its
pressing as it is "out there", and if 2.6.19 is another 2 months away...

