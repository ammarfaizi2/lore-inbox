Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUGBMyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUGBMyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUGBMyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:54:39 -0400
Received: from styx.suse.cz ([82.119.242.94]:5764 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264147AbUGBMyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:54:38 -0400
Date: Fri, 2 Jul 2004 14:56:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ricky Beam <jfbeam@bluetronic.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-bk way too fast
Message-ID: <20040702125624.GB10187@ucw.cz>
References: <40D64DF7.5040601@pobox.com> <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net> <20040621082355.GB1200@ucw.cz> <1088754797.4224.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088754797.4224.44.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 08:53:16AM +0100, David Woodhouse wrote:
> On Mon, 2004-06-21 at 10:23 +0200, Vojtech Pavlik wrote:
> > x86-64 has a different HPET driver than i386. And HPET is only used when
> > present in the machine (so far only AMD chipsets), _and_ reported by the
> > ACPI BIOS. Which is rather uncommon.
> 
> If we know which chipsets have it, why would we refrain from using it
> just because the BIOS doesn't report it?
 
Because it doesn't have resources allocated, and we don't know which
memory range is free to use so early at boottime.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
