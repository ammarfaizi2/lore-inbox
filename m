Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbSI2QYi>; Sun, 29 Sep 2002 12:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262801AbSI2QYi>; Sun, 29 Sep 2002 12:24:38 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:64386 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262799AbSI2QYh>;
	Sun, 29 Sep 2002 12:24:37 -0400
Date: Sun, 29 Sep 2002 17:30:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jbradford@dial.pipex.com,
       Linus Torvalds <torvalds@transmeta.com>, jdickens@ameritech.net,
       mingo@elte.hu, jgarzik@pobox.com, kessler@us.ibm.com,
       linux-kernel@vger.kernel.org, saw@saw.sw.com.sg, rusty@rustcorp.com.au,
       richardj_moore@uk.ibm.com, andre@master.linux-ide.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929163048.GC19948@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	jbradford@dial.pipex.com, Linus Torvalds <torvalds@transmeta.com>,
	jdickens@ameritech.net, mingo@elte.hu, jgarzik@pobox.com,
	kessler@us.ibm.com, linux-kernel@vger.kernel.org, saw@saw.sw.com.sg,
	rusty@rustcorp.com.au, richardj_moore@uk.ibm.com,
	andre@master.linux-ide.org
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk> <20020929153817.GC1014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929153817.GC1014@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:38:17PM +0200, Jens Axboe wrote:

 > Update of drivers to 2.4 level is mainly a matter of Dave (or someone
 > else) resyncing his -dj tree and feeding it back to Linus.

Theres still boatloads of bits in my tree (around 4MB worth),
last night I spent some time banging on it trying to get things
into a usable, testable state again. The fact it doesn't boot
on my testboxes right now is somewhat limiting, as is being
buried alive in non-2.5 work.
 
 > > Most of my boxes won't even run a 2.5 tree yet. I'm sure its hardly
 > > unique. Middle of November we may begin to find out how solid the core
 > > code actually is, as drivers get fixed up and also in the other
 > > direction as we eliminate numerous crashes caused by "fixed in 2.4" bugs
 > Well why don't they run with 2.5?

Probably numerous reasons (as me). My laptop hangs on boot (no idea why),
my VIA C3 box dies with preemption, some other boxes are still unusable
due to broken SCSI drivers afair.

 > Alan, I think you are a pessimist painting a much bleaker picture of 2.5
 > than it deserves. Sure lots of drivers may be broken still, I would be
 > naive if I thought that this is all changed in time for oct 31.

There's mountains of silly one liner fixes for various problems
(from compile fixes to stability to security issues) in my tree
that need pushing to Linus, the hard part right now is finding
time to do so, but lots of it can even wait until after the feature freeze.
What's important right now is getting everything in that we *need*
included, (biggest absense imo is probably a replacement LVM right now)
 
 > Most of
 > these will not be fixed until people actually _use_ 2.5 (or 3.0-pre, or
 > whatever it will be called), and that will not happen until Linus
 > actually releases a -rc or similar. And so the fsck what? Noone expects
 > 2.6-pre/3.0-pre to be perfect.

*nods*, and with the addition of the various debugging aids that have
popped up in the last week or so, I've no doubt we're on track to nail
down a lot more hard-to-find bugs than we ever have been before long
before hitting a x.x.0 release

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
