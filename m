Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267626AbTAHAWW>; Tue, 7 Jan 2003 19:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTAHAWW>; Tue, 7 Jan 2003 19:22:22 -0500
Received: from bitmover.com ([192.132.92.2]:55485 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267626AbTAHAWV>;
	Tue, 7 Jan 2003 19:22:21 -0500
Date: Tue, 7 Jan 2003 16:30:50 -0800
From: Larry McVoy <lm@bitmover.com>
To: venom@sns.it
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: Honest does not pay here ...
Message-ID: <20030108003050.GF17310@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, venom@sns.it,
	Matthias Andree <matthias.andree@gmx.de>,
	linux-kernel@vger.kernel.org, andre@linux-ide.org
References: <20030107232820.GB24664@merlin.emma.line.org> <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In very semplicistic words:
> In 2.5/2.6 kernels, non GPL modules have a big
> penalty, because they cannot create their own queue, but have to use a default
> one.

I may be showing my ignorance here (won't be the first time) but this makes
me wonder if Linux could provide a way to do "user level drivers".  I.e.,
drivers which ran in kernel mode but in the context of a process and had
to talk to the real kernel via pipes or whatever.  It's a fair amount of
plumbing but could have the advantage of being a more stable interface
for the drivers. 

If you think about it, drivers are more or less open/close/read/write/ioctl.
They need kernel privileges to do their thing but don't need (and shouldn't
have) access to all the guts of the kernel.

Can any well traveled driver people see this working or is it nuts?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
