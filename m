Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWBQTKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWBQTKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWBQTKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:10:30 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:44987 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751115AbWBQTK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:10:29 -0500
Date: Fri, 17 Feb 2006 11:10:26 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060217191026.GA3136@taniwha.stupidest.org>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net> <20060217075829.GB22451@esmail.cup.hp.com> <20060217084605.GG4523@taniwha.stupidest.org> <20060217163605.GA26660@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217163605.GA26660@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 09:36:05AM -0700, Grant Grundler wrote:

> If the machine is suppose to support a 32-bit OS, then yeah, it's a
> BIOS bug. It all depends on who defines the support matrix.

Well, maybe.  I mean, the CPUs all have PAE (in 32-bit mode) and thus
can use 36-bit physical addressing these days (or more in the case of
amd chips).

> The other way is to reassign "invalid" resources (above 4GB) with
> "valid" ones (below 4GB).  I suspect windows is doing this and I'd
> rather see linux take this route as well if possible.

Hrm, it may be doing this.  I wonder how that works though with 4GB's
of RAM installed?

I originally thought Windows probably allowed the larger addresses
and use PAE but that might not be the case at all.
