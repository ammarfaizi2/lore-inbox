Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUFXSqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUFXSqC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUFXSqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:46:02 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7916
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264640AbUFXSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:44:42 -0400
Date: Thu, 24 Jun 2004 20:44:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624184447.GW30687@dualathlon.random>
References: <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <s5hsmclgcwl.wl@alsa2.suse.de> <20040624171620.GN30687@dualathlon.random> <s5hbrj8hkm9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbrj8hkm9.wl@alsa2.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:33:02PM +0200, Takashi Iwai wrote:
> Sure, in extreme cases, it can't work.  But at least, it _may_ work
> better than using only GFP_DMA.  And indeed it should (still) work
> on most of consumer PC boxes.  The addition of another zone would help
> much better, though.

of course agreed.
