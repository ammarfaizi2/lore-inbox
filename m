Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTGXPje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271696AbTGXPje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:39:34 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:55231 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S269461AbTGXPjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:39:32 -0400
Date: Thu, 24 Jul 2003 08:54:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Larry McVoy <lm@bitmover.com>, Nikita Danilov <Nikita@Namesys.COM>,
       Shawn <core@enodev.com>, Hans Reiser <reiser@Namesys.COM>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@Namesys.COM>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
Message-ID: <20030724155432.GE12647@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tupshin Harper <tupshin@tupshin.com>, Larry McVoy <lm@bitmover.com>,
	Nikita Danilov <Nikita@Namesys.COM>, Shawn <core@enodev.com>,
	Hans Reiser <reiser@Namesys.COM>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	reiserfs mailing list <reiserfs-list@Namesys.COM>
References: <3F1EF7DB.2010805@namesys.com> <3F1F6005.4060307@tupshin.com> <1059021113.7911.13.camel@localhost> <3F1F66F0.1050406@tupshin.com> <1059024090.9728.22.camel@localhost> <16159.48809.812634.455756@laputa.namesys.com> <3F1FF6DB.2090104@tupshin.com> <20030724152649.GB12647@work.bitmover.com> <3F1FFBF9.2050308@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1FFBF9.2050308@tupshin.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 08:26:49AM -0700, Larry McVoy wrote:
> > >http://www.namesys.com/code.html (requires bitkeeper)?                     
>                                                                               
> If someone can tell me what it is that you need and I'll do it and send you   
> a patch.  I'm cloning that tree now.                                          
   
I pulled the r4 tree into linux-2.5 (2.6) top of trunk, merged it (it all
automerged, ya gotta love that, see below), and sent out a patch.  If someone
else needs that patch let me know.

takepatch: 2782 new revisions, 8 conflicts in 357 files
440459 bytes uncompressed to 2455963, 5.58X expansion
Running resolve to apply new work ...
resolve: found 25 renames in pass 1
resolve: resolved 25 renames in pass 2
Content merge of Makefile OK
Content merge of arch/um/drivers/ubd_kern.c OK
Content merge of fs/jbd/transaction.c OK
Content merge of fs/proc/proc_misc.c OK
Content merge of include/linux/sched.h OK
Content merge of kernel/ksyms.c OK
Content merge of kernel/sched.c OK
resolve: resolved 7 conflicts in pass 3
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
