Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVBFTrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVBFTrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVBFTrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:47:04 -0500
Received: from ns.suse.de ([195.135.220.2]:6107 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261313AbVBFTqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:46:48 -0500
Date: Sun, 6 Feb 2005 20:46:39 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, pavel@suse.cz,
       linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: Re: [2.6 patch] i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk
Message-ID: <20050206194639.GH18245@wotan.suse.de>
References: <20050206184447.GW3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206184447.GW3129@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 07:44:47PM +0100, Adrian Bunk wrote:
> acpi_save_state_disk does nothing and is completely unused.
> 
> This patch was already ACK'ed by Pavel Machek.

Since it affects both i386 and x86-64 it should be pushed by the ACPI
people. However it's no bugfix and so definitely nothing for 2.6.11,
so it'll take quite some time anyways.

-Andi
