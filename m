Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVFLMxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVFLMxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVFLMxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 08:53:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40907 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S261711AbVFLMxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 08:53:40 -0400
Date: Sun, 12 Jun 2005 13:54:47 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       subbie subbie <subbie_subbie@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050612125447.GD9765@gallifrey>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com> <20050612071213.GG28759@alpha.home.local> <Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be> <20050612110539.GA9765@gallifrey> <20050612111659.GH28759@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612111659.GH28759@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3smp (i686)
X-Uptime: 13:50:34 up 59 days, 12:19, 37 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau (willy@w.ods.org) wrote:
> On Sun, Jun 12, 2005 at 12:05:39PM +0100, Dr. David Alan Gilbert wrote:
> > * Geert Uytterhoeven (geert@linux-m68k.org) wrote:
> > 
> > > Or make the kernel print /proc/partitions when it is unable to mount root?
> > 
> > I posted a patch in February to do this:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110946077026065&w=2
> 
> This is even better ! I will probably backport it to 2.4 to merge in my
> kernels ;-)

That would be nice (I'd like to see it in 2.6); I wrote it for two reasons:
   1) Because often the info you need has already scrolled off
    and because of the panic you can't scroll back.

   2) When talking to users on help channels the only thing they
     can normally tell you is the last 'failed to mount root' line
     and don't really no what to look back for, by having a
     few line summary you can more easily get someone to type out.

1) could be cured by not actually panic'ing.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
