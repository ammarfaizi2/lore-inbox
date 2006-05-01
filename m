Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWEAVV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWEAVV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWEAVV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:21:59 -0400
Received: from fmr18.intel.com ([134.134.136.17]:40373 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932265AbWEAVV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:21:57 -0400
Date: Mon, 1 May 2006 14:20:52 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Message-ID: <20060501212051.GG32385@goober>
References: <20060427014141.06b88072.akpm@osdl.org> <p73vesv727b.fsf@bragg.suse.de> <20060427121930.2c3591e0.akpm@osdl.org> <200604272126.30683.ak@suse.de> <20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com> <445220AB.9000606@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445220AB.9000606@grupopie.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 03:03:23PM +0100, Paulo Marques wrote:
> Martin Bligh wrote:
> >>[...]
> >I don't want to boot it, as that gets into security nightmares, but I 
> >should be able to provide something that does static testing.
> 
> Actually, booting might not be that bad using a virtual machine with qemu.

Honestly, the security nightmare begins with the compile.  A patch to
the build system can result in arbitrarily insecure commands being run
during the compile - way easier than doing something that affects the
compiled kernel.  A machine doing automatic compiles of untrusted
patches should be viewed as completely sacrificial from the beginning.

-VAL
