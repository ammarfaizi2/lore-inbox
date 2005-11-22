Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVKVXMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVKVXMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKVXMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:12:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030240AbVKVXMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:12:41 -0500
Date: Wed, 23 Nov 2005 00:12:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: kaber@trash.net, evil@g-house.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [2.6 patch] do not select NET_CLS
Message-ID: <20051122231235.GC3963@stusta.de>
References: <20051116235813.GS5735@stusta.de> <20051121155955.GW16060@stusta.de> <4381F2D2.5000605@trash.net> <20051122.143713.101129339.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122.143713.101129339.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:37:13PM -0800, David S. Miller wrote:
>...
> Changing config options of any kind can result in the main kernel
> image needing to be rebuilt.  One thing we can do to prevent human
> mistakes, is to make the "make modules" pass do a quick "is vmlinux
> uptodate?" check, and if not print out an error message explaining the
> situation and aborting the "make modules" attempt.

This won't work with CONFIG_IKCONFIG=y.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

