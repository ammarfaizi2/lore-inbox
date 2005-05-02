Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVEBEv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEBEv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 00:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEBEv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 00:51:58 -0400
Received: from mahonia.com ([216.99.203.20]:11405 "EHLO mischief.mahonia.com")
	by vger.kernel.org with ESMTP id S261629AbVEBEv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 00:51:56 -0400
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
From: Mark McPherson <mark@mahonia.com>
Reply-To: mark@mahonia.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 01 May 2005 21:51:54 -0700
Message-Id: <1115009515.22963.12.camel@mischief.mahonia.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed since well back in the 2.6.11-mmX series that top always
reports the load average as 1.00 unless and until I kill apcupsd [an APC
ups daemon].  If I do that the load average swiftly drops to 0.00 when
the computer is idle.  Thought it was likely an application issue but
perhaps it is related so maybe I had better mention it.

I'm pretty sure the 2.6.12-rcX Linus tree does the same thing, while
vanilla 2.6.11 and the -ac tree don't display this behavior.

apcupsd doesn't seem to actually use excessive resources -- CPU or
memory -- even if I let it run for a long time, and the CPU temperature
remains at the correct idle value when idle [even though the load
average is reported as 1.00].

I don't see corresponding behavior with kswapiod here after a day of
uptime with 2.6.12-rc3-mm2.

Cheers,
Mark
-- 
Mark McPherson <mark@mahonia.com>
