Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTKXWY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTKXWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:24:28 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:42929 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261332AbTKXWY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:24:26 -0500
Date: Mon, 24 Nov 2003 14:24:13 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Larry McVoy <lm@bitmover.com>,
       Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031124222413.GA27604@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Theodore Ts'o <tytso@mit.edu>, Larry McVoy <lm@bitmover.com>,
	Ricky Beam <jfbeam@bluetronic.net>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <20031124155034.GA13896@work.bitmover.com> <Pine.GSO.4.33.0311241405070.13188-100000@sweetums.bluetronic.net> <20031124192432.GA20839@work.bitmover.com> <Pine.LNX.4.53.0311241459320.2333@chaos> <20031124203321.GA9036@thunk.org> <Pine.LNX.4.53.0311241628230.3173@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311241628230.3173@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 04:34:43PM -0500, Richard B. Johnson wrote:
> On Mon, 24 Nov 2003, Theodore Ts'o wrote:
> 
> > On Mon, Nov 24, 2003 at 03:05:24PM -0500, Richard B. Johnson wrote:
> > > Attempt to copy the raw drive to /dev/null.  If that works, the
> > > drive is likely okay, but the fs got fsucked up by software. You
> > > might be able to mount the drive on a 2.4.22 machine if you have a
> > > spare. Then you might be able to selectively copy important stuff
> > > to another drive, after which you can make a new file-system as
> > > a "repair".
> >
> > The error messages Larry reported were obviously reported by the
> > hardware, and were **not** filesystem errors.
> >
> > 						- Ted
> 
> Yes but an attempt to read beyond the limits of the physical
> drive will provide you with a lot of **interesting** hardware
> errors. This happens if the file-system gets corrupt.

Yeah, I think Richard may be right.  Anyway, the drive sort of reads
from the raw partition.  It gets a IDE reset and then it reads.  I can
read it a second time with no reset.  Haven't tried a reboot between
reads, hang on, yeah, a reboot brings the errors back.

But, fscking the dd-ed image gets me less errors so I'm trying that 
route to get the data back.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
