Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSCNSKr>; Thu, 14 Mar 2002 13:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311711AbSCNSK1>; Thu, 14 Mar 2002 13:10:27 -0500
Received: from boden.synopsys.com ([204.176.20.19]:29127 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S311701AbSCNSKV>; Thu, 14 Mar 2002 13:10:21 -0500
Date: Thu, 14 Mar 2002 19:10:10 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Larry McVoy <lm@work.bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020314191010.A4753@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> <20020314085456.B13186@riesen-pc.gr05.synopsys.com> <20020314074649.H9010@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314074649.H9010@work.bitmover.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's much better. If someone haven't started yet figurring out what
revision label to use for cloning, better stick to the Larry's one
(later labels may produce conflicts in Makefile :)

On Thu, Mar 14, 2002 at 07:46:49AM -0800, Larry McVoy wrote:
> On Thu, Mar 14, 2002 at 08:54:56AM +0100, Alex Riesen wrote:
> > Just tried it:
> > $ bk clone -rv2.4.18-pre8 linux-2.5 linux-2.4
> > remote: ERROR-rev v2.4.18-pre8 doesn't exist
> 
> Whoops, sorry, I thought I had checked that.  OK, try
> 
> 	bk clone -rv2.4.0 linux-2.5 linux-2.4
> 
> and then try the pull.
