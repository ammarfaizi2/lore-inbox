Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWAIPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWAIPjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAIPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:39:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:34264 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964798AbWAIPji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:39:38 -0500
From: Andi Kleen <ak@suse.de>
To: Matt Tolentino <metolent@cs.vt.edu>
Subject: Re: [patch 1/2] add __meminit for memory hotplug
Date: Mon, 9 Jan 2006 16:39:28 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, discuss@x86-64.org, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org
References: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
In-Reply-To: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091639.28570.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 16:19, Matt Tolentino wrote:

> Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
> ---
> diff -urNp linux-2.6.15/arch/i386/mm/init.c linux-2.6.15-matt/arch/i386/mm/init.c
> --- linux-2.6.15/arch/i386/mm/init.c	2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.15-matt/arch/i386/mm/init.c	2006-01-06 11:06:44.000000000 -0500

Won't this need an x86-64 specific patch too?   I don't think
any code in x86-64 has __meminit yet.

-Andi
