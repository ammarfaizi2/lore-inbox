Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTI2PED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTI2PED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:04:03 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:32426 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263506AbTI2PEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:04:00 -0400
Date: Mon, 29 Sep 2003 08:03:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Valdis.Kletnieks@vt.edu
Cc: John Bradford <john@grabjohn.com>, Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
Message-ID: <20030929150356.GA31116@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Valdis.Kletnieks@vt.edu, John Bradford <john@grabjohn.com>,
	Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <20030925122838.A16288@discworld.dyndns.org> <20030925182921.GA18749@work.bitmover.com> <200309290356.27600.rob@landley.net> <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk> <200309291323.h8TDNXtH020029@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309291323.h8TDNXtH020029@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 09:23:32AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 29 Sep 2003 12:24:47 BST, John Bradford <john@grabjohn.com>  said:
> Larry, how big is the BK binary for an x86? And how big are the docs?

# This includes the docs
$ du -sh /usr/libexec/bitkeeper/
21M

# source
$ bk -r cat | wc -l
1181207
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
