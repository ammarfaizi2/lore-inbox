Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266468AbRGCHqS>; Tue, 3 Jul 2001 03:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266463AbRGCHqI>; Tue, 3 Jul 2001 03:46:08 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:64703 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S266466AbRGCHp5>;
	Tue, 3 Jul 2001 03:45:57 -0400
Date: Tue, 3 Jul 2001 09:45:34 +0200
From: David Weinehall <tao@acc.umu.se>
To: kernel@ddx.a2000.nu
Cc: Guest section DW <dwguest@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Enforcer <enforcer@ddx.a2000.nu>
Subject: Re: Strange errors in /var/log/messages
Message-ID: <20010703094534.A27854@khan.acc.umu.se>
In-Reply-To: <20010702194212.A400@win.tue.nl> <Pine.LNX.4.30.0107022133380.6699-100000@ddx.a2000.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0107022133380.6699-100000@ddx.a2000.nu>; from kernel@ddx.a2000.nu on Mon, Jul 02, 2001 at 09:51:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 09:51:44PM +0200, kernel@ddx.a2000.nu wrote:
> On Mon, 2 Jul 2001, Guest section DW wrote:
> 
> > On Mon, Jul 02, 2001 at 05:16:23PM +0100, Alan Cox wrote:
> >
> > > > I'm running RedHat 7.0 with all official RH patches applied. The kernel I
> > > > currently run fow a few days is 2.2.19-7.0.8
> > > > I run the pre-compiled kernel of RH. Suddenly I the following messages:
> > > >
> > > > Jul  2 15:12:16 gateway SERVER[1240]: Dispatch_input: bad request line
> > > > 'BBXXXXXXXXXXXXXXXXXX%.176u%3
> > > > 00$nsecurity.%301$n%302$n%.192u%303$n\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> >
> > > These are for an application.  Not sure which or why
> >
> > See CERT Advisory CA-2000-22
> > 	http://www.infowar.com/iwftp/cert/advisories/CA-2000-22.html
> >
> >   "A popular replacement software package to the BSD lpd printing service
> >    called LPRng contains at least one software defect, known as a "format string
> >    vulnerability," which may allow remote users to execute arbitrary code on
> >    vulnerable systems."
> 
> I just read the article. It seems somebody tried to exploid a bug in
> LPRng. Unfortunately I didn't check the TCP/IP connections at the time of
> attack (with netstat), so I couldn't tell who was connected to port 515.
> The article suggest upgrading to 3.6.25. I'm currenlty running 3.7.4-23.
> I assume I'm not vulnerable, but those 'errors' in the logfile really
> scared the heck out of me! :) To be certain, I just blocked poort 515 for
> outbound connections. :)
> 
> Bye the way, sorry this message was off-topic, but I didn't know it was a
> LPRng issue, not a kernel issue.

A good idea is to block all ports, then open only those you know needs to
be open. Paranoia is good.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
