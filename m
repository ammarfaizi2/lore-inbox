Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbQLKXbC>; Mon, 11 Dec 2000 18:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbQLKXaw>; Mon, 11 Dec 2000 18:30:52 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:29705 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130067AbQLKXap>;
	Mon, 11 Dec 2000 18:30:45 -0500
Date: Mon, 11 Dec 2000 15:00:26 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Frédéric L . W . Meunier 
	<0@pervalidus.net>,
        linux-kernel@vger.kernel.org
Subject: Re: SysRq behavior
In-Reply-To: <20001211000439.B2583@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0012111440460.296-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> 
> > I don't remember having the same problem months (6?) ago when
> > I built my first Kernel with this enabled (well, maybe I never
> > touched the key).
> > 
> > When built into the Kernel, by only pressing the
> > PrintScreen/SysRq the current application is terminated (tested
> > on a console and GNU screen). Is this just me or I should
> > expect it?
> 
> Probably bug. Happens for me, too, and it is pretty nasty.

Just played with this bug. It doesn't kill a login shell but does any
app running on it. I just went looking for where "Quit" is printed
out. When I press SysRq Quit is printed on the command line. Any ideas?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
