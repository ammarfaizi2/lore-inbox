Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSL0P2f>; Fri, 27 Dec 2002 10:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSL0P2f>; Fri, 27 Dec 2002 10:28:35 -0500
Received: from unthought.net ([212.97.129.24]:9137 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S264975AbSL0P2e>;
	Fri, 27 Dec 2002 10:28:34 -0500
Date: Fri, 27 Dec 2002 16:36:51 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More tests [Was: Problem with read blocking for a long time on /dev/scd1]
Message-ID: <20021227153651.GA27643@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
References: <87adj0b3hj.fsf@stark.dyndns.tv> <87u1h799v5.fsf@stark.dyndns.tv> <87of7euj51.fsf_-_@stark.dyndns.tv> <20021222201345.GG30634@unthought.net> <87n0mxt8md.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87n0mxt8md.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 03:58:02AM -0500, Greg Stark wrote:
...
> > AFAIK 2.4.X broke at 2.4.19-pre6 - something was changed that related to
> > the order in which read requests are scheduled.
> 
> I originally had the problem with 2.4.18 and only updated to 2.4.20-ac2 hoping
> it would solve the problem. It doesn't look like the same issue as yours.

I agree.

> 
> When your process is blocked, what wait channel does ps -elf list for it?
> What system call does strace -T show it executing and for how long?

I will check this evening when the backup starts.

> I wonder what else is on the ide channels, perhaps if I move things around so
> it's the only device on that channel it would help?

I have four seagate drives, one (master) on each channel of two Promise
adapters.

There's a bunch of other disks in the system as well, but these are the
drives where I notice the problem.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
