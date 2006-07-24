Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGXP4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGXP4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWGXP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:56:16 -0400
Received: from [212.70.63.67] ([212.70.63.67]:6407 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932202AbWGXP4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:56:15 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CFQ will be the new default IO scheduler - why?
Date: Mon, 24 Jul 2006 18:57:43 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607241857.43399.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> On Mon, 24 Jul 2006, Matthias Andree wrote:
> > On Sun, 23 Jul 2006, Paa Paa wrote:
> >> The default IO scheduler in 2.6.18 will be CFQ (Complete Fair Queuing)
> >> instead of AS (Anticipatory Scheduler) as described here:
> >> http://wiki.kernelnewbies.org/Linux_2_6_18. I tried to find (here, at
> >> lkml) the discussion about this change with no luck.
> >
> > That wiki document nicely shows the advantage of the scheduler, namely
> > that you have "ionice", which isn't possible for AS or Deadline
> > Schedulers - this allows the operating system to run processes like
> > updatedb with "nice I/O", meaning these hold when you're doing other
> > I/O.
>
> Should there be a default scheduler per filesystem?  As some filesystems
> may perform better/worse with one over another?

It's currently perDevice, and should probably be extended to perMount.

Thanks!

--
Al

