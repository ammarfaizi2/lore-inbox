Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268219AbUHKU3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268219AbUHKU3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUHKU3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:29:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59833 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268222AbUHKU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:29:19 -0400
Date: Wed, 11 Aug 2004 22:26:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
       trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040811202617.GC1550@openzaurus.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <1092215024.2816.8.camel@laptop.fenrus.com> <20040811090622.GC674@elf.ucw.cz> <1092235779.5028.93.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092235779.5028.93.camel@dhcppc4>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >.adds possibility to react to
> > > > critical overtemp: it tries to call /sbin/overtemp, and only if
> > that fails calls /sbin/poweroff.
> 
> Does /sbin/overtemp exist anyplace, or is this a proposal
> to create it?  What might it do?

It does not exist anywhere, but probably will exist in SL92.

It might:
* shutdown faster (poweroff is very carefull but not too fast;
* display big red message "sorry your cpu overheated" then shutdown :-)
* do nothing (use with care if your thermal sensor is flakey)

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

