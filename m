Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTLWIvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 03:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTLWIvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 03:51:31 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:7227 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S265053AbTLWIv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 03:51:29 -0500
Date: Tue, 23 Dec 2003 10:51:13 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031223085113.GN1524@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Gene Heskett <gene.heskett@verizon.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <20031221150312.GJ25043@ovh.net> <20031222183554.GN6438@matchmail.com> <20031222211247.GL1455@niksula.cs.hut.fi> <200312221752.01730.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312221752.01730.gene.heskett@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 05:52:01PM -0500, you [Gene Heskett] wrote:
> >
> >(It's a 7.0 Red Hat).
> >
> >It does
> >   runcmd "Sending all processes the KILL signal..."  /sbin/killall5
> > -9 before
> >   [ -n "$SWAPS" ] && runcmd "Turning off swap: " swapoff $SWAPS
> >in /etc/rc6.d/S01reboot and I've seen the "Sending all processes the
> > KILL signal..." message appear before the memory freeing loop
> > starts rolling.
> 
> If its a pristine rh7.0 install, that version of bind has a notorious 
> rootkit hole.  

Pristine - hell no. None of my install are pristine :).

Bind - hell no. I may be^W^Wam stupid, but does *anyone* put boxes in
production without disabling services first?

> So I wonder if the machine has been kitted by some 
> script kiddie whose good at covering his tracks but not the rest of 
> the housekeeping.

Uh, it may be rooted allright, but I seriously doubt that is cause of this
symptom.

> An OS upgrade does seem to be in order, lots has happened since 7.0.  

I know that, but I'm not exactly lacking interesting admin things to do so
that I would run around upgrading all the boxes there are lying around on
the corners each time a distro upgrade comes up. The box works for what it
is supposed to do (a miracle, that, considering it's a 200MHz/64MB
screamer), it's behind a fw, most services are disabled. And it's actually
being phased out of production anyway.

Sure, if I had endlessly time on my hands, I'd upgrade the distro, but right
now, I'll have to settle with just keeping the crucial services up-to-date.

> 7.3 with an updated kernel is my firewall, uptime is about 95 days 
> now. 

No problem with getting good uptimes with this kernel (2.4.21-jam1). I only
had to boot it to install the do_brk patch.

> It was shut down while I was out of state for a couple of 
> months last fall.

Longest uptimes I've got are with 2.0 and 2.2 so far. And I have a number of
RH 6.2 distros running still. I see no fundamental problem with an old
distro (as long as you know the down sides (keep the services up-to-date, no
>2GB file support with all applications etc etc).


-- v --

v@iki.fi
