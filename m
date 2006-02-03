Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWBCRyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWBCRyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWBCRyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:54:17 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:15483 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751271AbWBCRyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:54:17 -0500
Date: Fri, 3 Feb 2006 09:54:16 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: cpufreq oddness on 2.6.16-rc1-mm4
Message-ID: <20060203175416.GA24452@hexapodia.org>
References: <20060203174048.GA13427@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203174048.GA13427@hexapodia.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 09:40:48AM -0800, Andy Isaacson wrote:
> On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> >  git-cpufreq.patch
> 
> I haven't had time to debug it further, but cpufreq seems broken on my
> Thinkpad X40 with 2.6.16-rc1-mm4.  It was working fine with
> 2.6.15-rc5-mm3.  Automatic scaling doesn't function any more - my
> PentiumM 1.4 GHz is fixed at 598 MHz.

Additional info - if I boot with AC connected, the CPU is fixed at 1395
MHz.  So perhaps this is due to an ACPI change?

(I *do* see the "magic disappearing C4" that Pavel was talking about,
but that seems to have no connection to this problem.)

I still don't understand why there's nothing in
/sys/devices/system/cpu/cpu0, though.

-andy
