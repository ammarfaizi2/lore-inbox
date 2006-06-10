Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWFJVL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWFJVL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWFJVL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:11:58 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:10146 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1030508AbWFJVL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:11:57 -0400
Date: Sat, 10 Jun 2006 15:11:56 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org
Subject: ACPI patch process problems again
Message-ID: <20060610211156.GT1651@parisc-linux.org>
References: <20060610164150.GR1651@parisc-linux.org> <pan.2006.06.10.20.51.12.109916@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2006.06.10.20.51.12.109916@free.fr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 10:51:13PM +0200, Matthieu CASTET wrote:
> Le Sat, 10 Jun 2006 10:41:50 -0600, Matthew Wilcox a ?crit?:
> > ACPI ADDRESSn resources can describe both memory and port io, but the
> > current code assumes they're descibing memory, which isn't true for HP's
> > ia64 systems.
> > 
> There already a patch for that in -mm kernel

Yes, the original author just contacted me to tell me.  It seems to me
that we have a process problem when a bug gets fixed on March 28th,
but not propagated upstream by June 10th.  That's almost 11 weeks,
and I'm sure it'll be more by the time it's finally merged.  I thought
the days of ACPI process problems were behind us ;-(
