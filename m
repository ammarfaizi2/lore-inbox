Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTHLOju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270391AbTHLOju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:39:50 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:21655 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270386AbTHLOjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:39:47 -0400
Date: Tue, 12 Aug 2003 07:39:42 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Useful(?) BK trick
Message-ID: <20030812143942.GA23150@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley asked me if there was some way to get diffs between any two revs
of a file on bkbits.net and the answer is yes if you are willing to type in
the revs.

You can navigate to a file by going to www.bkbits.net and then working your
way down to the project of interest, then the repo, then "Browse the source
tree", then click on the file.  You'll get offered a list of revisions,
click on one of those and you should be at a URL that looks like

	http://project/repo/diffs/path/to/file@rev

You can put anything you want in for the rev, it can be a range.  To see
1.2 vs 1.5 diffs you can do file@1.2..1.5 and hit return.  It may be useful
to know that "+" always means the most recent rev in BK so to diff everything
from 1.2 to now that's file@1.2..+

FYI...
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
