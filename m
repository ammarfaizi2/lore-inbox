Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHWNwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHWNwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUHWNwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:52:53 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:46078 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264377AbUHWNwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:52:51 -0400
Subject: Re: PROBLEM: Linux system clock is running 3x too fast
From: Fast Clock <fastclock@earthlink.net>
To: Zan Lynx <zlynx@acm.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1093234996.5055.5.camel@titania.zlynx.org>
References: <1093233957.3094.49.camel@apc>
	 <1093234996.5055.5.camel@titania.zlynx.org>
Content-Type: text/plain
Message-Id: <1093269176.2805.23.camel@apc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 08:52:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The stock Fedora Core 2 x86_64 kernel is compiled with powernow-k8. It
does not fix the system clock problem.

# dmesg | grep powernow
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version
1.00.09b)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
powernow-k8: cpu_init done, current fid 0x0, vid 0x12


On Sun, 2004-08-22 at 23:23, Zan Lynx wrote:
> Have you tried compiling in or loading the module powernow-k8?
> 
> On Sun, 2004-08-22 at 22:05, Fast Clock wrote:
> > My Athlon 64 laptop (HP Pavilion zv5000z) dual-boots Linux and Windows
> > XP. The Windows system clock is running accurately but the Linux system
> > clock is running 3 times too fast.

