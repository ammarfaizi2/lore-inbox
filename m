Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbUK3ACO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUK3ACO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUK3ACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:02:14 -0500
Received: from zaphod.axian.com ([64.122.196.146]:49373 "EHLO zaphod.axian.com")
	by vger.kernel.org with ESMTP id S261873AbUK3ABX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:01:23 -0500
Subject: Re: odd behavior with r8169 and pcap
From: Terry Griffin <terryg@axian.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20041129231800.GB3880@electric-eye.fr.zoreil.com>
References: <1101751909.2291.21.camel@tux.hq.axian.com>
	 <20041129210213.GA3880@electric-eye.fr.zoreil.com>
	 <1101766059.3382.57.camel@tux.hq.axian.com>
	 <20041129231800.GB3880@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Message-Id: <1101772869.3382.101.camel@tux.hq.axian.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 16:01:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 15:18, Francois Romieu wrote:
> Terry Griffin <terryg@axian.com> :
> [...]
> 
> Ok, thanks for the info. It may sound like voodoo, but...
> 
> Could you pass acpi=off to the kernel and disable whatever acpi
> or USB option appearing in the bios ?
> 
> --
> Ueimor

It was already voodoo with pcap in the causal loop. So more
voodoo doesn't have the thrill it might have otherwise.

Passing acpi=off did the trick. Throughput is at the higher rate
with or without pcap monitoring. I did not have to change any BIOS
settings.

More info previously promised:

- Removing one of the RealTek adapters did not help.
- The problem still exists in 2.6.10-rc2 and 2.6.10-rc2-bk13.

Terry


