Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265421AbRGBTvs>; Mon, 2 Jul 2001 15:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265420AbRGBTvi>; Mon, 2 Jul 2001 15:51:38 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:7690 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S265421AbRGBTva>;
	Mon, 2 Jul 2001 15:51:30 -0400
Date: Mon, 2 Jul 2001 21:51:44 +0200 (CEST)
From: <kernel@ddx.a2000.nu>
To: Guest section DW <dwguest@win.tue.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Enforcer <enforcer@ddx.a2000.nu>
Subject: Re: Strange errors in /var/log/messages
In-Reply-To: <20010702194212.A400@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0107022133380.6699-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001, Guest section DW wrote:

> On Mon, Jul 02, 2001 at 05:16:23PM +0100, Alan Cox wrote:
>
> > > I'm running RedHat 7.0 with all official RH patches applied. The kernel I
> > > currently run fow a few days is 2.2.19-7.0.8
> > > I run the pre-compiled kernel of RH. Suddenly I the following messages:
> > >
> > > Jul  2 15:12:16 gateway SERVER[1240]: Dispatch_input: bad request line
> > > 'BBXXXXXXXXXXXXXXXXXX%.176u%3
> > > 00$nsecurity.%301$n%302$n%.192u%303$n\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
>
> > These are for an application.  Not sure which or why
>
> See CERT Advisory CA-2000-22
> 	http://www.infowar.com/iwftp/cert/advisories/CA-2000-22.html
>
>   "A popular replacement software package to the BSD lpd printing service
>    called LPRng contains at least one software defect, known as a "format string
>    vulnerability," which may allow remote users to execute arbitrary code on
>    vulnerable systems."

I just read the article. It seems somebody tried to exploid a bug in
LPRng. Unfortunately I didn't check the TCP/IP connections at the time of
attack (with netstat), so I couldn't tell who was connected to port 515.
The article suggest upgrading to 3.6.25. I'm currenlty running 3.7.4-23.
I assume I'm not vulnerable, but those 'errors' in the logfile really
scared the heck out of me! :) To be certain, I just blocked poort 515 for
outbound connections. :)

Bye the way, sorry this message was off-topic, but I didn't know it was a
LPRng issue, not a kernel issue.

Thanks!

