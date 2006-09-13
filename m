Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWIMIi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWIMIi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWIMIi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:38:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37850 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750790AbWIMIi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:38:28 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
Date: Wed, 13 Sep 2006 09:06:47 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1158078540.6780.61.camel@localhost.localdomain> <200609121729.12009.ak@suse.de> <1158086743.6780.86.camel@localhost.localdomain>
In-Reply-To: <1158086743.6780.86.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609130906.47361.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 20:45, Alan Cox wrote:
> Ar Maw, 2006-09-12 am 17:29 +0200, ysgrifennodd Andi Kleen:
> > If the system really locks up afterwards they will likely never see it
> > though?
>
> They'll see it at boot.
>
> > I just don't think the printk will that useful and if it locks up people
> > will blame Linux anyways even with printk.
>
> Which is why I also intend to make sure the drivers aren't defaulting to
> ignore but all do it properly and require a force flag. PCIPCI_FAIL
> means it doesn't work. No driver should be ignoring that flag.

Ok that would be more reasonable. Just the printk alone seems to be fairly
pointless to me.

-Andi
