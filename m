Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbTF1Tdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTF1Tdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:33:50 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:26582 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265342AbTF1Tdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:33:49 -0400
Date: Sat, 28 Jun 2003 12:47:26 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Larry McVoy <lm@bitmover.com>, Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628194726.GF17623@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Larry McVoy <lm@bitmover.com>,
	Scott McDermott <vaxerdec@frontiernet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain> <20030628031920.GF18676@work.bitmover.com> <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk> <20030628191847.GB8158@work.bitmover.com> <20030628193857.GH841@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628193857.GH841@gallifrey>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 08:38:57PM +0100, Dr. David Alan Gilbert wrote:
> Tapes are a pain; but at the type of 40GB range is it worth considering
> a pile of external USB/Firewire hard drives?

Maybe it's not obvious to the none BK users.  BK _replicates_ the database
of revision history.

	cd /tmp
	bk clone /repos/l/linux/linux-2.5 
	rm -rf /repos/l/linux/linux-2.5
	bk clone /tmp/linux-2.5 /repos/l/linux/linux-2.5

That's a noop.  Nothing was lost.  And BK is excellent at incremental
updates, far better than anything else in existence.  

And BK does in file and cross file integrity checks.

So backing up using BK to another mirror is faster, simpler, and more
reliable.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
