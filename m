Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWHaCyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWHaCyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 22:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWHaCyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 22:54:45 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:12690 "EHLO
	asav14.insightbb.com") by vger.kernel.org with ESMTP
	id S1750946AbWHaCyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 22:54:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HACfs9USBT4lYLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] drivers/input/misc/wistron_btns.c: fix section mismatch
Date: Wed, 30 Aug 2006 22:54:42 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
References: <20060826160922.3324a707.akpm@osdl.org> <200608301926.37928.dtor@insightbb.com> <20060830233617.GS18276@stusta.de>
In-Reply-To: <20060830233617.GS18276@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302254.43536.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 19:36, Adrian Bunk wrote:
> On Wed, Aug 30, 2006 at 07:26:37PM -0400, Dmitry Torokhov wrote:
> > On Wednesday 30 August 2006 16:35, Adrian Bunk wrote:
> > > This patch fixes the following section mismatch
> > > (dmi_matched() is referenced from struct dmi_ids):
> > >
> > 
> > dmi_ids is only used in select_keymap, which is __init. Moreover,
> > dmi_ids is marked __initdata so I do not see what the problem is...
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/revert-input-wistron-fix-section-reference-mismatches.patch
>

Ah, I see. I think it is fixed properly in Linus' tree.

-- 
Dmitry
