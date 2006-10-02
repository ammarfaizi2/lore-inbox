Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWJBJyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWJBJyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWJBJyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:54:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:15315 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750837AbWJBJyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:54:14 -0400
To: Wink Saville <wink@saville.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with 2.6.18 kernel
References: <45206777.7020405@saville.com>
From: Andi Kleen <ak@suse.de>
Date: 02 Oct 2006 11:54:02 +0200
In-Reply-To: <45206777.7020405@saville.com>
Message-ID: <p733ba7hwlh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> I'm trying to build the 2.6.18 kernel for a Intel Core 2 Duo 2.4GHZ in
> a Asus P5W DH Deluxe Motherboard which has a 975 chip set. It does
> work when booting from a 2.6.15-27 kernel installed from Ubuntu 2.06
> LTS.
> 
> When failing I get three messages on the screen:
> 
> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> PCI: Not using MMCONFIG
> Intel-rng: FWH not detected

Can you boot with initcall_debug and report the complete output?

-Andi
