Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVCOUad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVCOUad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVCOUWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:22:14 -0500
Received: from stark.xeocode.com ([216.58.44.227]:40104 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261579AbVCOUS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:18:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	<20050314083717.GA19337@elf.ucw.cz>
	<200503140855.18446.jbarnes@engr.sgi.com>
	<Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 15 Mar 2005 15:18:35 -0500
Message-ID: <87r7igll2c.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@osdl.org> writes:

> And those occasional people are often not going to eb very good at
> reporting bugs. If they don't see anything happening, they'll just give up
> rather than bother to report it. So I do think we want the fairly verbose
> thing enabled by default. You can then hide it with the graphical bootup 
> for "most people".

Loading the usb drivers on my machine dumps 155 lines into dmesg. Surely
that's a bit excessive?

But really for me it's the network drivers that actually annoy me. They dump
stuff into dmesg during the regular course of operation. As a result it
doesn't take long until the boot messages leave the buffer. Of course they're
in the log files, but running dmesg and getting screenfulls of the same
messages about boring network events over and over just annoys me.

-- 
greg

