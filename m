Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272735AbRILKKy>; Wed, 12 Sep 2001 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272736AbRILKKo>; Wed, 12 Sep 2001 06:10:44 -0400
Received: from [195.157.147.30] ([195.157.147.30]:16147 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S272735AbRILKKd>; Wed, 12 Sep 2001 06:10:33 -0400
Date: Wed, 12 Sep 2001 11:12:29 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/meminfo swap counter wraparound in 2.2
Message-ID: <20010912111229.P6126@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010912105151.L6126@dev.sportingbet.com> <E15h6vz-0004Fb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15h6vz-0004Fb-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 12, 2001 at 11:07:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 11:07:55AM +0100, Alan Cox wrote:
> > I would be amazed if this bug were not also in the main 2.2.x tree.  Is a fix
> > likely or even possible in 2.2 ?
> 
> No fix is planned for 2.2
> 

OK, thanks.  I'm a little reluctant to move this box to 2.4 yet (before Monday
we had almost a year's uptime out of it- frequent reboots are frowned upon),
but looking at the 2.4 source, the relevant bits of fs/proc/array.c and
include/linux/kernel.h look exactly the same, so the problem could be there as
well.

Am I being dumb?

Sean
