Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVJAVhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVJAVhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVJAVhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:37:07 -0400
Received: from smtpout3.uol.com.br ([200.221.4.194]:32667 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750863AbVJAVhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:37:06 -0400
Date: Sat, 1 Oct 2005 18:36:55 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051001213655.GE6397@ime.usp.br>
Mail-Followup-To: Nigel Cunningham <ncunningham@cyclades.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050927111038.GA22172@ime.usp.br> <1127863912.4802.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1127863912.4802.52.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 28 2005, Nigel Cunningham wrote:
> Hi Rogerio.

Hi, Nigel.

> On Tue, 2005-09-27 at 21:10, Rogério Brito wrote:
> > Hi there. I'm seeing a really strange problem on my system lately and I
> > am not really sure that it has anything to do with the kernels.
> 
> I've seen the thread mostly following the hardware line. I'd like to
> enquire down the kernel path because I've seen occasional, impossible
> to reproduce problems too.

Nice. I also don't want to rule out anything before I really understand
what's going on.

> Can I ask first a few questions:

Of course.

> 1) Are you using vanilla kernels, or do you have other patches applied?

Yes, all the kernels that I use are just plain vanilla kernels taken
straight from kernel.org. No other patches applied.

> 2) Are you using ext3 only?

Yes, I am.

> 3) Is the corruption only ever in memory, or seen on disk too?

I have noticed the problem mostly on disk. One strange situation was
when I was untarring a kernel tree (compressed with bzip2) and in the
middle of the extraction, bzip2 complained that the thing was
corrupted.

I removed what was extracted right away and tried again to extract the
tree (at this point, suspecting even that something in software had
problems). The problem with bzip2 occurred again. Then, I rebooted the
system an the problem magically went away.

> 4) Is the corruption only in one filesystem or spread across several
> (if applicable)? (ie in / but not /home or others?)

I only have one filesystem right now, but given the difficulties that
I'm seeing, I do plan to go back to a multiple filesystem setup (which I
always used but thought that was overkill---nothing like time to teach
us something what is safest).

If you want to know anything else, don't hesistate to ask.


Regards,

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
