Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965572AbWIRIWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965572AbWIRIWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965569AbWIRIWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:22:07 -0400
Received: from mx1.suse.de ([195.135.220.2]:23004 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965572AbWIRIWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:22:05 -0400
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 (EM64T Core2 Duo, DG965RY) PCI mmconfig regression - complete hangs on boot - ACPI interaction?
References: <20060914195344.GC27531@curie-int.orbis-terrarum.net>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 10:22:03 +0200
In-Reply-To: <20060914195344.GC27531@curie-int.orbis-terrarum.net>
Message-ID: <p73wt814mac.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> [Please CC me, I'm not subscribed to LKML.]
> 
> I recently picked up a new server of really new hardware, and I've run
> into a number of issues with the latest git HEAD kernels. I'll make
> separate posts for each of the issues.
> 
> CPU: Intel Core 2 Duo E6400
> Motherboard: Intel DG965RY
> BIOS revisions: July/07/2006 AND September/06/2006 (tried both)
> 
> The most significant of them - is that somewhere between 2.6.17.11 and
> 2.6.18-rc6-git4, MMCONFIG is now being used, but leads to a complete
> hardware hang (SYSRQ does not respond).

Known issue. I've already sent Linus fixes for that, but he hasn't merged them 
yet.

-Andi
