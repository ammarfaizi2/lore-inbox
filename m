Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTLFBEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTLFBEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:04:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61840
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264898AbTLFBEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:04:32 -0500
Date: Sat, 6 Dec 2003 02:05:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Clark <jamie@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa3 scsi oops
Message-ID: <20031206010505.GB14904@dualathlon.random>
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA79308.3070300@metaparadigm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 07:52:40PM +0800, Jamie Clark wrote:
> I made the quick fix (disabling rq_mergeable) and started the load test.
> Will let it run for a week or so.

does your later recent email means it deadlocked again even with this
disabled?

Could you try again with 2.4.23aa1 again just in case?

> FYI an observation from my last test: the read latency seems to be much
> improved and more consistent under this kernel (2.4.23pre6aa3, before
> the oops and before this fix).  The maximum latency seemed steady over
> the whole test without any of the longish pauses that showed up under
> 2.4.19. Quite a difference.

nice to hear! thanks.
