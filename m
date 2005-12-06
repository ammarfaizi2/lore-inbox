Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVLFRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVLFRIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVLFRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:08:30 -0500
Received: from hornet.berlios.de ([195.37.77.140]:52508 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S932402AbVLFRIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:08:30 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Tue, 6 Dec 2005 18:08:41 +0100
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
References: <200512060054.jB60svAU003892@pincoya.inf.utfsm.cl>
In-Reply-To: <200512060054.jB60svAU003892@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20051206170944.281D72CEC@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 01:54, Horst von Brand wrote:
> Michael Frank <mhf@users.berlios.de> wrote:
>
> [...]
>
> > As to security, most vulnerabilities are hard to
> > exploit remotely
>
> Right.
>
> >          and practical security can be much more
> > improved by hiding detailed software versions from
> > clients.
>
> Ever heard of nmap <http://www.nmap.org>? 

I wrote my original post with nmap in mind.

I use nmap all the time, it is a excellent tool. At times I 
used nmap to scan those IP's who scan my IP and have 
unleashed at times a barrage of counter-scans to the point 
of bringing my connection pretty much down. Some of those 
scanners must have big pipes.

> Or perhaps 
> noticed all kinds of attacks against Linux using old
> exploits or Windows specific ones? 

100s to 1000s of unsolicited packets mainly to windows 
specific service ports day and also several burst attacks a 
day. These days I just leave the firewall logging off in 
order to play less with nmap ;)

> Hiding versions is 
> /not/ secure. At most marginally so, 

Sorry, do not concur. Unlike windows and such, linux is a 
_fast_ moving target. The best bet to crack it a _inside_  
job by a trusted perpetrator (for example the debian case 
or the corruption of the kernels bk derived cvs repo ), 
which still ring bells... Remote exploitation of the odd 
random vulnerability in the absence of detailed version 
info is as likely as winning a jackpot.

> and the pain for 
> whoever needs the version for legitimate reasons just
> isn't worth it.

Oh well, If I have a legitimate requirement for the detailed 
versions someone is running, I can ask. 

Again, most violations are  made possible by:

a) access to hardware or admin/root passwords (what was  the 
kernel.org case tracked to?)

b)  access to version info and utilizing a exploit short 
term (the debian case)

IMHO, to have good security, 1) use open source and 2)  
sound implementation of common sense security procedures 
beginning with the basic doctrine who does not have to know 
won't know.  Yes, some things seem never to change :-(

> >                                                    
> > Apache 2 on linux 2.6 will do instead of providing full
> > vendor specific package versions!
> >
> > As to drivers, in case 3 month driver delay matters, HW
> > vendor can improve situation substantially  by not
> > waiting 6+ months before (if at all) releasing
> > drivers/docs for linux!
>
> For /server/ type workloads, where you /need/ stability,
> you carefully pick the hardware and then run a selected
> "enterprise" distro on it. The distro people do the hard
> work of keeping your kernel up to date and secure. And
> even worry about a smooth upgrade to the next version.
> For a price, sure. But either you really need it (and
> gladly pay the price) 

sure

> or you don't (in which case you 
> have nothing to complain about).

kernel.org kernels and gentoo linux will do for me.

	Thank you
	Michael


