Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTF1ACd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTF1AC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:02:28 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:25544 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264961AbTF1ACT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:02:19 -0400
Date: Fri, 27 Jun 2003 17:16:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CaT <cat@zip.com.au>, nick@snowman.net,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628001625.GC18676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CaT <cat@zip.com.au>, nick@snowman.net,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627165519.A1887@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow.  So this is a different server, this is the second backup machine.
So in about a week we've had the primary die, the secondary have a bad
disk, and the second backup have a bad disk.  

I don't know if you all realize this but at one point we had corrupted 
data in several repositories and the backups were also shot.  But because
BK replicates the data  (as Peter Chubb says "you are lost in a maze of
BitKeeper repositories, all almost the same") I was able to look through
other replicas until I found the missing chunks and put them back.

Maybe we should take a page from Oracle and start advertising.  How's this?

    BitKeeper makes your source unbreakable

I'm only half joking.  If SVN/CVS/Clearcase/anyone else had both the primary
and the backup fail, you are just screwed, there isn't anything you can do.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
