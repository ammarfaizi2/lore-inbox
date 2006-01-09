Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWAIWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWAIWrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWAIWrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:47:13 -0500
Received: from mxsf04.cluster1.charter.net ([209.225.28.204]:61313 "EHLO
	mxsf04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751261AbWAIWrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:47:12 -0500
X-IronPort-AV: i="3.99,347,1131339600"; 
   d="scan'208"; a="1802242742:sNHT16510900"
Subject: Re: 64 bit kernel
From: Stan Gammons <s_gammons@charter.net>
To: "Mike McCarthy, W1NR" <lists@w1nr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001c01c61520$2cbba6b0$6d0ea8c0@LoJackOne.LoJack.com>
References: <1136780835.6695.37.camel@falklands.home.pc>
	 <001c01c61520$2cbba6b0$6d0ea8c0@LoJackOne.LoJack.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 16:47:57 -0600
Message-Id: <1136846877.6695.44.camel@falklands.home.pc>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 08:25 -0500, Mike McCarthy, W1NR wrote:
> I saw a similar issue many years ago that turned out to be a chipset bug. 
> This was a PII system that used 16 bit wide modules.  When using only one 
> module, the chipset "fooled" the OS into thinking that it was doing 32 bit 
> wide operations.  However, it failed at full speed.  Reducing the memory bus 
> speed or installing modules in pairs "fixed" the problem.  I suspect a bus 
> or memory controller issue rather than the kernel.
> 
> The failure mode was exactly as you describe.  It manifested itself as disk 
> errors or DMA failures.  Unfortunately the chipset vendor determined that it 
> was a silicon bug and said that they would NOT fix it!

Hi Mike, 

What chipset was that?  

This board has an nVidia nForce 3 chipset on it.  This brings about
another question. What is the consensus on using the amd74xx.c patch for
the nForce 3/4 chipset that nVidia has on their website?  It's supposed
to improve HD performance. Any comments on including that patch in the
existing kernel?  How about the pros and or cons of adding that patch
and rebuilding a system specific kernel?



Stan




