Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWATKpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWATKpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWATKpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:45:47 -0500
Received: from waste.org ([64.81.244.121]:9366 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750810AbWATKpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:45:47 -0500
Date: Fri, 20 Jan 2006 04:47:22 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_DOUBLEFAULT Kconfig fix
Message-ID: <20060120104722.GJ27079@waste.org>
References: <20060120090159.GA9800@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120090159.GA9800@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:01:59AM +0100, Ingo Molnar wrote:
> move CONFIG_DOUBLEFAULT from the main Kconfig menu (!) into its proper
> place: the "Processor Type and features" submenu.

Hmm. Should have originally shown up under the CONFIG_EMBEDDED menu, I
guess Andrew moved it.

I'd kind of like to keep it in the embedded features menu, so that
it's clear that disabling it is a non-standard thing to do. But I
don't have a strong feeling about it.

-- 
Mathematics is the supreme nostalgia of our time.
