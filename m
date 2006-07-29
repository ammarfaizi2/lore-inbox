Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWG2WWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWG2WWD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWG2WWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:22:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:27627 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbWG2WWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:22:01 -0400
To: Robert Hancock <hancockr@shaw.ca>
Cc: iforone <floydstestemail@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
References: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
	<1153933737.200164.160870@m73g2000cwd.googlegroups.com>
	<1154007393.940693.259680@i42g2000cwa.googlegroups.com>
	<1154112339.037481.119210@p79g2000cwp.googlegroups.com>
	<44CAC249.1010605@shaw.ca>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2006 00:21:59 +0200
In-Reply-To: <44CAC249.1010605@shaw.ca>
Message-ID: <p73bqr83vco.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock <hancockr@shaw.ca> writes:

> Athlon 64/Opteron CPUs have support for moving this part of the RAM
> above 4GB to allow it to be used. This is part of the CPU's on-die
> memory controller so no special chipset support is needed.

In cheap boards >3.5GB RAM configurations are usually not officially
supported by the vendor (= not tested) and there are systems where it
doesn't work when enabled in the BIOS (doesn't work = kernel crashes
randomly when accessing bad memory ranges)

I guess it's a subtle hint that above 3GB of RAM you should be using
ECC DIMMs anyways, which need a more expensive workstation class
board.

-Andi
