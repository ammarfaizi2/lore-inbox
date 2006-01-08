Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752605AbWAHRLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbWAHRLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbWAHRLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:11:10 -0500
Received: from waste.org ([64.81.244.121]:18332 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1752605AbWAHRLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:11:08 -0500
Date: Sun, 8 Jan 2006 11:03:57 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] more UID16 fixes
Message-ID: <20060108170357.GC3356@waste.org>
References: <20060108124119.GH3774@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108124119.GH3774@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 01:41:19PM +0100, Adrian Bunk wrote:
> It seems the "make UID16 support optional" patch was checked when it 
> edited the -tiny tree some time ago, but it wasn't checked whether it
> still matches the current situation when it was submitted for inclusion 
> in -mm. This patch fixes the following bugs:
> - ARCH_S390X does no longer exist, nowadays this has to be expressed
>   through (S390 && 64BIT)
> - in five architecture specific Kconfig files the UID16 options
>   weren't removed
> 
> Additionally, it changes the fragile negative dependencies of UID16 to 
> positive dependencies (new architectures are more likely to not 
> require UID16 support).

Yeah, that's a better approach. Thanks.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
