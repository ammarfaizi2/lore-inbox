Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUJ1XpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUJ1XpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbUJ1XpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:45:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:52966 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263100AbUJ1XiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:38:13 -0400
Date: Fri, 29 Oct 2004 01:38:05 +0200
From: Andi Kleen <ak@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clustered apic patch missing APIC_DFR_CLUSTER def
Message-ID: <20041028233805.GA11384@wotan.suse.de>
References: <20041028112715.D14339@build.pdx.osdl.net> <200410281635.23848.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410281635.23848.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 04:35:23PM -0700, James Cleverdon wrote:
> Hmmm...  The patch containing APIC_DFR_CLUSTER and friends went
> into the -mm tree in the June/July timeframe.  It must not have
> been pushed with the main cluster patch.

Andrew moved it into the x86-64 kexec APIC patch for some unknown
reason.  And that obviously was not pushed ...

I already sent a patch to Linus and will send patches for 
the other known buglets too (warnings, safe_smp_processor_id())

-Andi
