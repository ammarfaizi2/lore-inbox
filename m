Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279895AbRJ3I7H>; Tue, 30 Oct 2001 03:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279821AbRJ3I65>; Tue, 30 Oct 2001 03:58:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1012 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S279896AbRJ3I6s>; Tue, 30 Oct 2001 03:58:48 -0500
Message-ID: <3BDE69A9.A3DE2070@mvista.com>
Date: Tue, 30 Oct 2001 00:49:45 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: Mike Fedyk <mfedyk@matchmail.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <3BDDBC90.7E16E492@lexus.com> <20011029151036.F20280@mikef-linux.matchmail.com> <3BDDE422.938C1D95@lexus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> Mike Fedyk wrote:
> 
> > On Mon, Oct 29, 2001 at 12:31:12PM -0800, J Sloan wrote:
> > > Say it ain't so! maybe I'm a bit dense, but is the 2.4 kernel also going
> > > to wrap around after 497 days uptime? I'd be glad if someone would
> > > point out the error in my understanding.
> >
> > Ahh, so that's why there haven't been any reports of higher uptimes... ;)
> 
> Yes, it all makes sense now -
> 
> Say, if the uptime field were unsigned it could
> reach 995 days uptime before wraparound -

Actually 497 days is from the max jiffies in an unsigned int.  Up time
converts this to seconds... (HZ = 100) jiffies units are 1/HZ.

George

> 
> Surely nobody would mind having to upgrade
> their kernel after 994+ days....
> 
> Well strictly speaking an upgrade isn't
> forced, but if the (perceived) uptime is down
> the tubes anyway, might as well update the
> kernel, or the distro level for that matter.
> 
> cu
> 
> jjs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
