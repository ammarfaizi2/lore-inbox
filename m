Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTE0QXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTE0QXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:23:21 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:50866 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263928AbTE0QXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:23:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.37850.528654.94908@gargle.gargle.HOWL>
Date: Tue, 27 May 2003 12:35:38 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
In-Reply-To: <20030527155259.GK8978@holomorphy.com>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<200305271048.36495.devilkin-lkml@blindguardian.org>
	<20030527130515.GH8978@holomorphy.com>
	<200305271729.49047.devilkin-lkml@blindguardian.org>
	<20030527153619.GJ8978@holomorphy.com>
	<16083.35048.737099.575241@gargle.gargle.HOWL>
	<20030527155259.GK8978@holomorphy.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin <wli@holomorphy.com> writes:

William> On Tue, May 27, 2003 at 11:48:56AM -0400, John Stoffel wrote:
>> Subarchitecture Type (PC-compatible, Voyager (NCR), NUMAQ (IBM/Sequent), Summit/EXA (IBM x440), Support for other sub-arch SMP systems with more than 8 CPUs, SGI 320/540 (Visual Workstation), Generic architecture (Summit, bigsmp, default)) [PC-compatible] (NEW) 
>> What the hell am I supposed to enter here?  This is just friggin ugly
>> and un-readable.  It should be cleaned up.  Or is it just that the
>> help entry is appended to the question improperly here?  That's sorta
>> what it looks like peering at it with my head turned to the left all
>> the way.

William> If you don't know, then just hit "enter".

Sure, I understand that, but what I'm really complaining about is the
text of the prompt.  When I do a 'make menuconfig' it's alot cleaner
and more understandable what's happening here.

Part of the problem is the specification in arch/i386/Kconfig, which I
think needs to be re-worked.  

In my case, I specified that the max number of CPUS is 2, since I only
have a dual CPU box.  So it's not a BIGCPU box.  Not sure how to make
this change... I'll have to find some time and play with this.

William> Yes, they're mutually exclusive. You can't build one that
William> will run on all those machines because the programming isn't
William> done right for that.  But the generic architecture option
William> will run on at least 3.

I see that when I dod the menuconfig, it's not clear at all when
running oldconfig.

John
