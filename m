Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031455AbWFOVfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031455AbWFOVfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031459AbWFOVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 17:35:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43169 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031455AbWFOVfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 17:35:21 -0400
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
In-Reply-To: <4491ABF7.4090204@drzeus.cx>
References: <1150385605.3490.85.camel@localhost.localdomain>
	 <449191EE.2090309@drzeus.cx>
	 <1150393058.3490.120.camel@localhost.localdomain>
	 <4491ABF7.4090204@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Jun 2006 22:51:40 +0100
Message-Id: <1150408300.3490.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-15 am 20:50 +0200, ysgrifennodd Pierre Ossman:
> Yes and no. It's for a code path that's never supposed to be hit (and
> isn't except for hardware so broken it doesn't work anyway).

Oh I see, I didn't realise it was just for the obscure corner case

