Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVEaB0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVEaB0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVEaB0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:26:49 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:27303
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S261855AbVEaBZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 21:25:49 -0400
Date: Mon, 30 May 2005 18:22:01 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] net/ieee80211/: remove pci.h #include's
Message-ID: <20050531012200.GC7950@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050530205634.GQ10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530205634.GQ10441@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 10:56:34PM +0200, Adrian Bunk wrote:

> I was wondering why editing pci.h triggered the rebuild of three files 
> under net/, and as far as I can see, there's no reason for these three 
> files to #include pci.h .

>  net/ieee80211/ieee80211_module.c |    1 -
>  net/ieee80211/ieee80211_rx.c     |    1 -
>  net/ieee80211/ieee80211_tx.c     |    1 -

I don't know where these came from since Host AP driver does not include
linux/pci.h into the files doing generic IEEE 802.11 processing. Anyway,
I have nothing against removing these include lines.

-- 
Jouni Malinen                                            PGP id EFC895FA
