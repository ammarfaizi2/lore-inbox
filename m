Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSI2Pdy>; Sun, 29 Sep 2002 11:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262666AbSI2Pdy>; Sun, 29 Sep 2002 11:33:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37827 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262664AbSI2Pdx>;
	Sun, 29 Sep 2002 11:33:53 -0400
Date: Sun, 29 Sep 2002 17:38:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jbradford@dial.pipex.com, Linus Torvalds <torvalds@transmeta.com>,
       jdickens@ameritech.net, mingo@elte.hu, jgarzik@pobox.com,
       kessler@us.ibm.com, linux-kernel@vger.kernel.org, saw@saw.sw.com.sg,
       rusty@rustcorp.com.au, richardj_moore@uk.ibm.com,
       andre@master.linux-ide.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929153817.GC1014@suse.de>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033311400.13001.5.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, Alan Cox wrote:
> On Sun, 2002-09-29 at 10:12, Jens Axboe wrote:
> > 2.5 is definitely desktop stable, so please test it if you can. Until
> > recently there was a personal show stopper for me, the tasklist
> > deadlock. Now 2.5 is happily running on my desktop as well.
> 
> Its very hard to make that assessment when the audio layer still doesnt
> work, most scsi drivers havent been ported, most other drivers are full
> of 2.4 fixed problems and so on.

I can only talk for myself, 2.5 works fine here on my boxes. Dunno what
you mean about audio layer, emu10k works for me.

SCSI drivers can be a real problem. Not the porting of them, most of
that is _trivial_ and can be done as we enter 3.0-pre and people show up
running that on hardware that actually needs to be ported. The worst bit
is error handling, this I view as the only problem.

Update of drivers to 2.4 level is mainly a matter of Dave (or someone
else) resyncing his -dj tree and feeding it back to Linus.

> Most of my boxes won't even run a 2.5 tree yet. I'm sure its hardly
> unique. Middle of November we may begin to find out how solid the core
> code actually is, as drivers get fixed up and also in the other
> direction as we eliminate numerous crashes caused by "fixed in 2.4" bugs

Well why don't they run with 2.5?

Alan, I think you are a pessimist painting a much bleaker picture of 2.5
than it deserves. Sure lots of drivers may be broken still, I would be
naive if I thought that this is all changed in time for oct 31. Most of
these will not be fixed until people actually _use_ 2.5 (or 3.0-pre, or
whatever it will be called), and that will not happen until Linus
actually releases a -rc or similar. And so the fsck what? Noone expects
2.6-pre/3.0-pre to be perfect.

I'm not worried.

-- 
Jens Axboe

