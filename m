Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUFUIZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUFUIZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUFUIX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:23:57 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:13696 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266163AbUFUIX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:23:29 -0400
Date: Mon, 21 Jun 2004 10:23:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-bk way too fast
Message-ID: <20040621082355.GB1200@ucw.cz>
References: <40D64DF7.5040601@pobox.com> <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:29:04PM -0400, Ricky Beam wrote:
> On Sun, 20 Jun 2004, Jeff Garzik wrote:
> >Something is definitely screwy with the latest -bk.
> 
> I'm not seeing any troubles...
> 
> [root:pts/11{4}]spork:~/[11:26 PM]:uname -a
> Linux spork.troz.com 2.6.7-SMP+BK@1.1400 #15 SMP BK[20040618194307] Fri Jun 
> 18 15:56:38 EDT 2004 x86_64 x86_64 x86_64 GNU/Linux
> 
> time.c: Using 1.193182 MHz PIT timer.
> 
> >My guess would be someone broke HPET, but maybe not judging from other
> >lkml reports.
> 
> It could be.  All my systems have an HPET enabled kernel, but none of them
> are actually reporting HPET as a timing source.
 
x86-64 has a different HPET driver than i386. And HPET is only used when
present in the machine (so far only AMD chipsets), _and_ reported by the
ACPI BIOS. Which is rather uncommon.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
