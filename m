Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVCIAXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVCIAXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCIATg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:19:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262251AbVCIAQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:16:08 -0500
Date: Wed, 9 Mar 2005 01:16:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-ID: <20050309001604.GC3146@stusta.de>
References: <20050308033846.0c4f8245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 03:38:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-mm1:
>...
> -fix-buggy-ieee80211_crypt_-selects.patch
> 
>  Was wrong.
>...

I'd say my patch was correct.

If it was buggy, I have yet to see a better patch.

With the current dependencies, IEEE80211_CRYPT_CCMP and 
IEEE80211_CRYPT_TKIP can't be included into Linus' tree since selecting 
them can result in invalid .config's [1].

cu
Adrian

[1] no matter how you think to be guilty - from a user's point
    of view it's simply currently broken

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

