Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRJ0DHC>; Fri, 26 Oct 2001 23:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279765AbRJ0DGw>; Fri, 26 Oct 2001 23:06:52 -0400
Received: from queen.bee.lk ([203.143.12.182]:63616 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S277514AbRJ0DGl>;
	Fri, 26 Oct 2001 23:06:41 -0400
Date: Sat, 27 Oct 2001 09:06:39 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
Message-ID: <20011027090639.A2053@bee.lk>
In-Reply-To: <20011026084328.A14814@bee.lk> <E15x6U0-0008Hs-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15x6U0-0008Hs-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 26, 2001 at 01:53:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 01:53:08PM +0100, Alan Cox wrote:
> 
> Turning off byte range support in the web server works suprisingly well for
> it.

But won't it affect retry features of other `good' software such as wget?  At
any rate, people are downloading from web/ftp sites on the Internet, which are
beyond our control, and apache hacks are anyway impossible.  However, I am
thinking of setting up a transparent proxy (squid/iptables) on the firewall and
let it handle the bandwidth limiting and the like.

> Another non hacking code approach would be to set up CBQ or other bandwidth
> limiters so that the users of download accelerator get no benefit.

I don't mind hacking approaches.  Otherwise, I won't be reading the LKML ;-)

> The advantage of the apache hacks is that you can make them actually suffer

That is a wonderful idea.  Trying to exploit features on the Internet should be
a punishable offence ;)

Regards,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

Exhilaration is that feeling you get just after a great idea hits you,
and just before you realize what is wrong with it.

