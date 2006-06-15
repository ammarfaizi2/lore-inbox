Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030582AbWFORVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbWFORVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030878AbWFORVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 13:21:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16256 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030582AbWFORVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 13:21:16 -0400
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
In-Reply-To: <449191EE.2090309@drzeus.cx>
References: <1150385605.3490.85.camel@localhost.localdomain>
	 <449191EE.2090309@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Jun 2006 18:37:37 +0100
Message-Id: <1150393058.3490.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-15 am 18:59 +0200, ysgrifennodd Pierre Ossman:
> Alan Cox wrote:
> > The data field is ulong, pointers fit in ulongs. Casting them to int is
> > bad for 64bit systems.
> 
> It's in my (rather large) queue. I'm just waiting for a merge window. :)

I'd have thought that one was a "Duh whoops, fix it now" kind of
submission for 2.6.17

