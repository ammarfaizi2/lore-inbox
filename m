Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311149AbSCNHzh>; Thu, 14 Mar 2002 02:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311381AbSCNHz0>; Thu, 14 Mar 2002 02:55:26 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:23206 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S311149AbSCNHzQ>; Thu, 14 Mar 2002 02:55:16 -0500
Date: Thu, 14 Mar 2002 08:54:56 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Larry McVoy <lm@work.bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020314085456.B13186@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313224255.F9010@work.bitmover.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried it:
$ bk clone -rv2.4.18-pre8 linux-2.5 linux-2.4
remote: ERROR-rev v2.4.18-pre8 doesn't exist

no, that's not a problem for me
-alex


On Wed, Mar 13, 2002 at 10:42:55PM -0800, Larry McVoy wrote:
> On Wed, Mar 13, 2002 at 11:33:27PM -0700, Ben Greear wrote:
> > Can you plz tell me (us) what the bk clone command is?
> > 
> > I tried:
> > 
> >   bk clone bk://linux24.bkbits.net//linux-2.4
> > 
> > and
> > 
> >   bk clone bk://linux24.bkbits.net///linux-2.4
> 
> Hi, Linus & Marcelo agreed that the right place for this is
> 
> 	bk://linux.bkbits.net/linux-2.4
> 
> and I just put it there, let me know if that doesn't work.
> 
> Also, if you have a linux-2.5 BK tree, you can save yourself a lot of 
> bandwidth by doing the following:
> 
> 	bk clone -rv2.4.18-pre8 linux-2.5 linux-2.4
> 	cd linux-2.4
> 	bk parent bk://linux.bkbits.net/linux-2.4
> 	bk pull
> 
> That will get you back to the baseline you should already have and 
> then just update your tree with what Marcelo added recently.
> 
> You don't have to do that, and for those of you with fast DSL lines you
> can skip, I don't care, but if you are trying to get a 2.4 tree over a
> modem, this is much much faster.
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
