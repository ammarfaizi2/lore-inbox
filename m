Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTDTQMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTDTQMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:12:16 -0400
Received: from mail.ithnet.com ([217.64.64.8]:43023 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263623AbTDTQMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:12:15 -0400
Date: Sun, 20 Apr 2003 18:24:13 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030420182413.7574930a.skraw@ithnet.com>
In-Reply-To: <1050789876.3961.22.camel@dhcp22.swansea.linux.org.uk>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	<1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
	<20030419190046.6566ed18.skraw@ithnet.com>
	<1050789876.3961.22.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Apr 2003 23:04:36 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2003-04-19 at 18:00, Stephan von Krawczynski wrote:
> > Ok, you mean active error-recovery on reading. My basic point is the
> > writing case. A simple handling of write-errors from the drivers level and
> > a retry to write on a different location could help a lot I guess.
> 
> It would make no difference. The IDE drive firmware already knows about
> such things.

Hm, maybe this is only another field where "knowing" differs from "doing" (the
right thing) sometimes.

> > Just to give some numbers: from 25 disk I bought during last half year 16
> > have gone dead within the first month. This is ridiculous. Of course they
> > are all returned and guarantee-replaced, but it gets on ones nerves to
> > continously replace disks, the rate could be lowered if one could use them
> > at least 4 months (or upto a deadline number of bad blocks mapped by the fs
> > - still guarantee but fewer replacement cycles).
> 
> I'd be changing vendors and also looking at my power/heat/vibration for
> that level of problems. I'm sure google consider hard disks as a
> consumable but not the rest of us 8)

Maybe I have something in common with google, I am re-writing large parts (well
over 50%) of the harddrives capacity on a daily basis (in the discussed setup).
How many people really do that?

Regards,
Stephan

