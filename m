Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTE0TeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTE0TeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:34:07 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:55739 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264077AbTE0Tdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:33:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.49299.914675.725102@gargle.gargle.HOWL>
Date: Tue, 27 May 2003 15:46:27 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: John Stoffel <stoffel@lucent.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70 compile error
In-Reply-To: <Pine.LNX.4.44.0305272010550.12110-100000@serv>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<200305271048.36495.devilkin-lkml@blindguardian.org>
	<20030527130515.GH8978@holomorphy.com>
	<200305271729.49047.devilkin-lkml@blindguardian.org>
	<20030527153619.GJ8978@holomorphy.com>
	<16083.35048.737099.575241@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0305272010550.12110-100000@serv>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roman> I agree and I already fixed this here, so with the next update
Roman> this will look like this:

Thanks Roman!  This will look alot better and be more easily
understood, by Aunt Tillie or even an aware kernel hacker.  wli not
withstanding, making it readable doesn't imply we're wasting time.  

Roman> Subarchitecture Type
>> 1. PC-compatible (X86_PC)
Roman>   2. Voyager (NCR) (X86_VOYAGER)
Roman>   3. NUMAQ (IBM/Sequent) (X86_NUMAQ)
Roman>   4. Summit/EXA (IBM x440) (X86_SUMMIT)
Roman>   5. Support for other sub-arch SMP systems with more than 8 CPUs (X86_BIGSMP)
Roman>   6. SGI 320/540 (Visual Workstation) (X86_VISWS)
Roman>   7. Generic architecture (Summit, bigsmp, default) (X86_GENERICARCH) (NEW)
Roman> choice[1-7]: 

Roman> This has other advantages too, one can see now which options
Roman> were newly added and the individual help texts are accessible.

Very nice, this will be great to have.

John

