Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUFDBSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUFDBSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUFDBSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:18:36 -0400
Received: from mfep1.odn.ne.jp ([143.90.131.179]:57236 "EHLO t-mta1.odn.ne.jp")
	by vger.kernel.org with ESMTP id S265233AbUFDBSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:18:35 -0400
Date: Fri, 4 Jun 2004 22:20:04 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nForce2 C1halt fixup, again
Message-ID: <20040604222004.A491%acyr@alumni.uwaterloo.ca>
References: <20040604112618.A1789%acyr@alumni.uwaterloo.ca> <200406031712.51458.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031712.51458.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.19i-ja0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 05:12:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> If bit 0x10000000 is not set then C1 Halt Disconnect is disabled.
> I have reports that it is unsupported on some boards.
> 
> So what about patch below instead?

Thanks Bartlomiej.  I reversed my patch and have applied yours and am
testing it now.  If my system doesn't freeze at all today, I think
that this should be a sufficient (and necessary!) patch.

One thing that bothers me though is that 2.6.5 was unstable in the
same way as far as I can recall.  Since this fixup was not included,
do you think it could have been related to something else that was
fixed in 2.6.6?  Maybe IO-APIC or the "acpi_skip_timer_override"
bootparam maybe?

Thanks again!

-- 
Aric Cyr <acyr at alumni dot uwaterloo dot ca>
