Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbULBEEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbULBEEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 23:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbULBEEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 23:04:54 -0500
Received: from ppp-202.176.140.13.revip.asianet.co.th ([202.176.140.13]:24470
	"EHLO mhfl2.mhf.dom") by vger.kernel.org with ESMTP id S261354AbULBEEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 23:04:52 -0500
From: pb <peterb968@yahoo.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Date: Sat, 27 Nov 2004 04:21:27 +0800
Cc: Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org
References: <1101292194.5805.180.camel@desktop.cunninghams> <m2d5y23o61.fsf@tnuctip.rychter.com> <20041124230232.GA22509@infradead.org>
In-Reply-To: <20041124230232.GA22509@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <20041202025433.C342A6F0BB@mhfl2.mhf.dom>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 November 2004 07:02, Christoph Hellwig wrote:
> On Wed, Nov 24, 2004 at 01:57:58PM -0800, Jan Rychter wrote:
> > Obviously you have never actually tried to use software suspend in real
> > life.
> > 
> > I would kindly suggest that you try to use it on your laptop for at
> > least several weeks in various circumstances. These features are a
> > result of years of user experience.

Lets say <UNDERLINE><BOLD>THOUSANDS OF MAN YEARS</UNDERLINE></BOLD>

> 
> I tend to buy laptops that just suspend when closing the lid, and no, I 
never
> had the strange desired to immediately reverse my choice.  Neither do I want
> to stop the shutdown that I just initiated.

Perhaps many less fortunate "users" ;) (_including_ myself), can change their 
minds anytime and open the lid again.

Thus, IMHO support for "changing ones mind" is imperative.

As to reboot, we hardly use it: 
- Test partitions get reset with the yournal doing the dirty work.
- The main partition gets rebooted only:
  - when some stupid app(s) leaked all memory away and we are out of swap
 ... sometimes weekly :-(
  - for (monthly) fsck.
  - when updating glibc twice a year or so

Dependable and flexible software suspend is a way of life yet to be 
experienced by many.

Offtopic, IMO a garbage collector is highly desirable...

Michael
