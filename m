Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTKGWZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTKGWZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:25:24 -0500
Received: from [212.86.245.254] ([212.86.245.254]:27266 "EHLO umka.bear.com.ua")
	by vger.kernel.org with ESMTP id S264377AbTKGPBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:01:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alex Lyashkov <shadow@itt.net.ru>
Organization: Home
To: Jan Kara <jack@suse.cz>
Subject: Re: [BUG] ext3 + diskquta + sync = deadlock
Date: Fri, 7 Nov 2003 17:01:36 +0200
User-Agent: KMail/1.4.1
References: <200311060744.23189.shadow@itt.net.ru> <20031106155936.GB25830@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031106155936.GB25830@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311071701.40557.shadow@itt.net.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 17:59, you wrote:
>   Hi,
>
> > I tred to test stabilyty of ext3 filesystem with high load.
> >
> > at one console do start/stop some programs.
> > at second console start script
> > ===
> > while [ 1 ]; do
> > mount -o remount,usrquota,grpquota /
> > sleep 5
> > done;
> > ===
> > for test how work fs sync.
> > After small time (less 10 min) i tred logon on third console and system
> > been locked.
> > I use RH kernel 2.4.18-27.x on RH 7.3 box.
> > logs tasks states in deadlock attached in mail.
>
>   Hmm... We had some deadlock in 2.4.18 (and still have one nasty in
> 2.4.23) but from the traces this looks different. I'll try to reproduce it.
>
today i try to compile kernel with enabled JDB debug and set debug level to 
100.
logs be avabled at http://freevps.com/download/ext3_bug/
If need other info or help for fixing it bug - i ready for it.

-- 
With best regards,
Alex
