Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbVKBOT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbVKBOT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbVKBOT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:19:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:37518 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932712AbVKBOT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:19:56 -0500
Date: Wed, 2 Nov 2005 15:19:54 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-ID: <20051102141954.GA29679@suse.de>
References: <2.494767362@selenic.com> <20051102170053.1c120a03.akpm@osdl.org> <20051102070337.GC4367@waste.org> <20051102174020.37da0396.akpm@osdl.org> <17256.33817.263105.197325@cargo.ozlabs.ibm.com> <20051102130435.GA24230@suse.de> <20051102141407.GB3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051102141407.GB3839@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Nov 02, Tom Rini wrote:

> I've always thought one of the nice points about ppc linux was that the
> kernel just booted on your board, no matter what crazy firmware there
> was.

I cant speak for anything else than CONFIG_PPC_MULTIPLATFORM, but I bet
almost noone really uses the boot wrapper from the kernel. An external
mkzimage for the rest of the supported boards sounds like a good plan.
Cant be that hard to maintain as the kernel interface is stable.
We have such thing in opensuse, it needs an update for PReP and iSeries
to provide the flat device tree.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
