Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268932AbRHBN7J>; Thu, 2 Aug 2001 09:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbRHBN67>; Thu, 2 Aug 2001 09:58:59 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:4849 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S268933AbRHBN6w>; Thu, 2 Aug 2001 09:58:52 -0400
Date: Thu, 2 Aug 2001 14:58:16 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3-users@redhat.com
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010802145816.U12470@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <Pine.LNX.4.33.0107300830010.2749-100000@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107300830010.2749-100000@titan.lahn.de>; from pmhahn@titan.lahn.de on Mon, Jul 30, 2001 at 08:37:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 30, 2001 at 08:37:07AM +0200, Philipp Matthias Hahn wrote:
> On Thu, 26 Jul 2001, Andrew Morton wrote:
> 
> > An update to the ext3 filesystem for 2.4 kernels is available at
> >
> > 	http://www.uow.edu.au/~andrewm/linux/ext3/
> I'm using ext3-0.9.4 with linux-2.4.7 / 2.4.8-pre1 and get some hangs on
> my dual P2-350:
> >From time to time I will have multiple CRON-Daemons in D-state and login
> hangs when logging in. It even happens during boot before my MTA is
> started.

Interesting.  Do you have the ability to hook up a serial console?  If
so, "alt-sysrq-T" to capture a backtrace of all the blocked processes
would be a great help.  Thanks.

Cheers,
 Stephen
