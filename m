Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTF1EH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 00:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbTF1EH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 00:07:29 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:28365 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265065AbTF1EH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 00:07:28 -0400
Date: Fri, 27 Jun 2003 21:21:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Joshua Penix <jpenix@binarytribe.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628042139.GB21243@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Joshua Penix <jpenix@binarytribe.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain> <20030628031920.GF18676@work.bitmover.com> <1056773286.10255.5.camel@granite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056773286.10255.5.camel@granite>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing to consider is that people already whine about bkbits performance,
it's a heavily used (in the disk arm sense) machine.  It's a lot easier to
just back the data up with BK itself.

That said, I'm shopping for SCSI RAIDs :)  No tapes.

On Fri, Jun 27, 2003 at 09:08:06PM -0700, Joshua Penix wrote:
> On Fri, 2003-06-27 at 20:19, Larry McVoy wrote:
> > On Fri, Jun 27, 2003 at 08:51:40PM -0400, Scott McDermott wrote:
> > > Larry McVoy on Fri 27/06 17:16 -0700:
> > > > I don't know if you all realize this but at one point we
> > > > had corrupted data in several repositories and the backups
> > > > were also shot.
> > > 
> > > ever hear of tapes?
> > 
> > bkbits is 45GB of data and growing.  Tapes are completely impractical,
> > that's why we have hot spares.
> 
> Boy you do need a good admin :)  Done correctly, tapes are quite
> practical for that amount of data.  A LTO or SDLT drive would back the
> entire 45GB thing up on a single tape, with room for at least one to two
> more full backups.  Granted, you're not going to have tape act as your
> hot backup, but it is a good third line of defense.  Plus data backed up
> to tape is immune from human or software error that may otherwise affect
> the hard-drive based data.
> 
> 45GB of code is very compressible and I'm sure good chunks of that don't
> change on a weekly basis.  I'd imagine you could get a weekly or
> bi-weekly full backup to tape in the span of about two hours, and then
> do nightly differentials which would probably be only 15 minutes in
> length.  A filesystem capable of doing snapshots would ensure
> consistency of the repositories on tape and would prevent you from
> having to shutdown bkbits while backing up.
> 
> --Josh
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
