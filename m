Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTE0PgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTE0PgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:36:04 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:43137 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263869AbTE0PgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:36:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.35048.737099.575241@gargle.gargle.HOWL>
Date: Tue, 27 May 2003 11:48:56 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
In-Reply-To: <20030527153619.GJ8978@holomorphy.com>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<200305271048.36495.devilkin-lkml@blindguardian.org>
	<20030527130515.GH8978@holomorphy.com>
	<200305271729.49047.devilkin-lkml@blindguardian.org>
	<20030527153619.GJ8978@holomorphy.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William> It should be even more obscure than that; CONFIG_X86_NUMAQ is
William> basically "you had _better_ have this machine and you had
William> _better_ know what you're doing even if you have one".

William> At any rate, one of us will look at making the option at
William> least harder to accidentally turn on.

I ran into this as well, since the 2.5.69-70 config entry is *really*
unclear on what you need to enter there, it's not in the standard
Y/N/M format for options.  For example:

    Kernel module loader (KMOD) [Y/n/?] y
  *
  * Processor type and features
  *
  Subarchitecture Type (PC-compatible, Voyager (NCR), NUMAQ (IBM/Sequent), Summit/EXA (IBM x440), Support for other sub-arch SMP systems with more than 8 CPUs, SGI 320/540 (Visual Workstation), Generic architecture (Summit, bigsmp, default)) [PC-compatible] (NEW) 


What the hell am I supposed to enter here?  This is just friggin ugly
and un-readable.  It should be cleaned up.  Or is it just that the
help entry is appended to the question improperly here?  That's sorta
what it looks like peering at it with my head turned to the left all
the way.

Are these choices all mutually exclusive?  Or can you build a kernel
which will run on all these machines?  Now that would be interesting
for a distro to have... not.  *grin*

John


