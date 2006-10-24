Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752102AbWJXHq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbWJXHq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWJXHq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:46:26 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:44050 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752102AbWJXHqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:46:25 -0400
Date: Tue, 24 Oct 2006 09:46:22 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
Subject: Re: Linux 2.6.19-rc3
Message-ID: <20061024074622.GC4354@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 04:22:59PM -0700, Linus Torvalds wrote:
> 
> Ok,
>  a few days late, because I'm a retard and didn't think of doing a release 
> when I should have. 
> 
> I'm also a bit grumpy, because I think people are sending me more stuff 
> than they should at this stage in the game. We've been pretty good about 
> keeping the later -rc releases quiet, please keep it that way.
> 
> That said, it's mostly harmless cleanups and some architecture updates. 
> And some of the added warnings about unused return values have caused a 
> number of people to add error handling. And on the driver front, there's 
> mainly new driver ID's, and a couple of new drivers.

The genirq changes broke boot on my x86-64 x366 machine. It needs
these two patches:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2

It also broke tg3 on at least one other machine, so this is not
specific to my machine.

Cheers,
Muli
