Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVLESMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVLESMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVLESMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:12:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751388AbVLESMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:12:09 -0500
Date: Mon, 5 Dec 2005 19:12:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: hostap@shmoo.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: Re: [RFC: -mm patch] drivers/net/wireless/hostap/hostap_main.c shouldn't #include C files
Message-ID: <20051205181207.GH9973@stusta.de>
References: <20051203122309.GD31395@stusta.de> <20051205021409.GB8953@jm.kir.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205021409.GB8953@jm.kir.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 06:14:09PM -0800, Jouni Malinen wrote:
> On Sat, Dec 03, 2005 at 01:23:09PM +0100, Adrian Bunk wrote:
> > This patch contains an attempt to properly build hostap.o without 
> > #incude'ing C files.
> 
> Looks good. However, I did not test this now since this did not apply to
> netdev-2.6 (it does not have hostap_main.c). Did the hostap.c to
> hostap_main.c rename go only to -mm? I would prefer to do this kind of
> changes in a single place and I thought netdev-2.6 would be that. I'm
> not following -mm tree at all and it would be easier to go through
> patches if they are against netdev-2.6 upstream branch.

The hostap_main.c rename is in the git-netdev-all tree that gets pulled 
into -mm. I don't know the exact setup of Jeff's (Cc'ed) git trees.

> Jouni Malinen

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

