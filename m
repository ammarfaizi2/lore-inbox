Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSABEEK>; Tue, 1 Jan 2002 23:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286693AbSABED7>; Tue, 1 Jan 2002 23:03:59 -0500
Received: from [206.98.161.5] ([206.98.161.5]:47235 "HELO
	blossom.learningpatterns.com") by vger.kernel.org with SMTP
	id <S286688AbSABEDt>; Tue, 1 Jan 2002 23:03:49 -0500
Subject: RE: Problems booting 2.4.17
From: Edward Muller <emuller@learningpatterns.com>
To: "Chris, Lo Cheuk Kong" <Chris.Lo@corp.sunday.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A5681DBDB02D31186070008C7733BED088A127E@exchan01.mandarin.com>
In-Reply-To: <3A5681DBDB02D31186070008C7733BED088A127E@exchan01.mandarin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 01 Jan 2002 23:03:02 -0500
Message-Id: <1009944182.2881.12.camel@cc234543-a>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm. Maybe it's a binutils problems like what was reported by some
debian sid users.


On Tue, 2002-01-01 at 20:20, Chris, Lo Cheuk Kong wrote:
> 
> Thanks for info. My workaround is that: don't use initrd image and it boots
> fine! 
> My hardware setup is simple and allows me to put modules back into the
> kernel. For 2.4.17, I drop the initrd line in the lilo...
> 
> -----Original Message-----
> From: Edward Muller [mailto:emuller@learningpatterns.com]
> Sent: Wednesday, January 02, 2002 2:08 AM
> To: chris.lo@corp.sunday.com
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Problems booting 2.4.17
> 
> 
> For now I've moved back to 2.4.16, which boots without a problem. I had
> lots of work to do to get those systems up and configured so I haven't
> had time to play.
> 
> I'm not sure what is causing the problem. I know how to make an initrd
> image and it's there. It may be a problem with devfs because I remember
> that Mandrake based their devfs scripts on some very very very old stuff
> from the devfs ditribution (which is being removed IIRC).
> 
> It's probably not fs based as you are using reiserfs and I'm using ext3.
> 
> Anyway ... For now I've gone back to 2.4.16, but I'd like to try 2.4.17.
> So if you happen to have some time and figure it out, please let me
> know.
> 
> On Mon, 2001-12-31 at 23:51, Chris Lo wrote:
> > Good Morning,
> > 
> > I had the same problem, with resierfs. Any workaround 
> > found?
> > 
> > Have a happy new year!!
> > 
> > Regards,
> > Chris
> > 
> > 
> > 
> > 
> > Hello all.
> > 
> > I'm having problems booting 2.4.17 on a Mandrake 8.1 system (with all
> > current updates).
> > 
> > When I boot 2.4.17 (with an initrd image) I get the following...
> > 
> > kernel boots ...
> > Creating root device
> > mkrootdev: mknod failed: 17
> > Mounting root filesyste with flags data=ordered
> > Mount: error 16 mounting ext3 flags data=ordered
> > ...Tried to remount without flags and fails with the same error...
> > Kernel Panic: No initrd found ...
> > 
> > I am using ext3 / /boot /usr /var & /home filesystems
> > 
> > 2.4.8-34.1mdk boots fine however.
> > 
> > I'm about to go try 2.4.16 (it was working with reiserfs partitions
> > before).
> > 
> > The machine is an AMD Athalon 1.3 Ghz on an EPOC board with a 3ware 7800
> > series RAID card, with three 75/80 GB drives in a RAID 5 array.
> > 
> > Anyone else run into something like this? 
> > 
> > I'll report back about 2.4.16 and if anyone would like more info, just
> > shout.
> > 
> > 
> > -- 
> > -------------------------------
> > Edward Muller
> > Director of IS
> > 
> > 973-715-0230 (cell)
> > 212-487-9064 x115 (NYC)
> > 
> > http://www.learningpatterns.com
> > -------------------------------
> > 
> -- 
> -------------------------------
> Edward Muller
> Director of IS
> 
> 973-715-0230 (cell)
> 212-487-9064 x115 (NYC)
> 
> http://www.learningpatterns.com
> -------------------------------
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

