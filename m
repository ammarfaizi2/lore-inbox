Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSK0NVu>; Wed, 27 Nov 2002 08:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSK0NVu>; Wed, 27 Nov 2002 08:21:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9744 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262492AbSK0NVt>; Wed, 27 Nov 2002 08:21:49 -0500
Date: Wed, 27 Nov 2002 14:29:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANN: syscalltrack 0.80 "Tanned Otter" released
Message-ID: <20021127132906.GA4483@atrey.karlin.mff.cuni.cz>
References: <20021123201015.GD6536@alhambra> <20021126181947.GB1376@zaurus> <20021126210314.GZ6536@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126210314.GZ6536@alhambra>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> syscalltrack also has better filtering than strace, and supports
> actions - fail the system call if it passed that filter, suspend the
> process if it passed that filter, etc. 

I can do that with ptrace, too. See subterfugue.

> Basically, there are things which strace is good for, and there are
> things subterfuge is good for, and there are things syscalltrack is
> good for. Use the right tool for the job. You can see more about
> syscalltrack's capabilities on the website. 

Agreed, whole system under subterfugue would be a pain.

> [1] You can probably emulate syscalltrack's system wide behaviour by
> ptracing init and all of its forked children, but your system will
> slow to a crawl. With syscalltrack, you'll barely feel anything. 

Agreed, speed difference is *huge*.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
