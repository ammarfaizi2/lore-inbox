Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268545AbUHLNDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268545AbUHLNDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268546AbUHLNDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:03:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:63444 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268545AbUHLNC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:02:58 -0400
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE
	workaround?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Clem Taylor <clemtaylor@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411B118B.4040802@pobox.com>
References: <411AFD2C.5060701@comcast.net>  <411B118B.4040802@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092312030.21994.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 13:00:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 07:43, Jeff Garzik wrote:
> Older Seagates cannot cope with this unique, but spec-correct behavior.
> 
> This issue cannot even be worked around with "nblocks % 15 == 1", as was 
> previously thought.  Using that formula just makes the problem harder to 
> reproduce.

It fixes it completely on the drivers/ide driver.


