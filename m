Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWBASFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWBASFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBASFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:05:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932448AbWBASFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:05:22 -0500
Date: Wed, 1 Feb 2006 10:05:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl initialization of zone_reclaim_mode
In-Reply-To: <20060201095549.6fca4944@dxpl.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0602011004340.21884@g5.osdl.org>
References: <20060201095549.6fca4944@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Feb 2006, Stephen Hemminger wrote:
>
> Fix warning about initialization of sysctl table in current 2.6.16-rc1
> git tree. It could cause a nasty if anyone wrote to it.

Already fixed in the current tree by Christoph Lameter,

		Linus
