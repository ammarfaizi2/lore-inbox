Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278758AbRJVMMJ>; Mon, 22 Oct 2001 08:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278755AbRJVML7>; Mon, 22 Oct 2001 08:11:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21592 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278758AbRJVMLs>; Mon, 22 Oct 2001 08:11:48 -0400
Date: Mon, 22 Oct 2001 14:12:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Case where VM of 2.4.13pre2aa falls apart
Message-ID: <20011022141225.J26029@athlon.random>
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB05298FB8@NL-ASD-EXCH-1> <20011019224721.B1464@dardhal.mired.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011019224721.B1464@dardhal.mired.net>; from jdomingo@internautas.org on Fri, Oct 19, 2001 at 10:47:21PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 10:47:21PM +0000, José Luis Domingo López wrote:
> On Friday, 19 October 2001, at 02:39:00 -0500,
> Leeuw van der, Tim wrote:
> 
> > Hello,
> > 
> > I've observed a case where the VM of 2.4.13pre2aa totally falls apart. I
> > know it's not the latest of Andrea's VM tweaks, but I didn't yet get a
> > chance to compile&reboot into a later version. I've noticed a similar
> > breakdown in one of the first pre-release kernels with the Andrea VM, btw.
> > [...description of problem apparently related to Mozilla ...]
> >
> Maybe what happens here doesn't have anything in common with what you
> experienced, but a couple of days ago I suffered a full X server crash due
> to a _big_ memory leak with Mozilla in one specific web page.
> 
> Linux kernel 2.4.12, Mozilla 0.9.5, and X 4.1.0. Open
> www.securityfocus.org with Mozilla. For a couple of minutes, it seems that
> all is going on nicely. Afterwards, and without any kind of user
> interaction with Mozilla, both mozilla and X processes start increasing
> their sizes, slowly, but steadily.

It certainly makes sense it's the userspace that has a leak and so the
system will start to swap and slowdown compared to the condition when
lots of free memory was available.

Andrea
