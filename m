Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275756AbRJBBzR>; Mon, 1 Oct 2001 21:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275757AbRJBBzI>; Mon, 1 Oct 2001 21:55:08 -0400
Received: from sushi.toad.net ([162.33.130.105]:45954 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S275756AbRJBByw>;
	Mon, 1 Oct 2001 21:54:52 -0400
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
To: linux-kernel@vger.kernel.org
Date: Mon, 1 Oct 2001 21:54:49 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011002015449.F367480B@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> We need to know when is_sony_vaio_laptop so that we can
> stop this from happening.  So either we put the dmi scan
> earlier (which Alan says is in the works) or else we allow
> the creation of the proc entries at init time but reject
> read/write accesses after init time.  I'll make up a patch
> that does the latter, but it would be nicest if the proc
> entries were omitted altogether.

On second thought I think I'll just wait for the dmi scan
to be moved and in the meantime warn Vaio users no to
read or write the numerically named files under /proc/bus/pnp.
That means not using lspnp or setpnp without the '-b' option
either.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
