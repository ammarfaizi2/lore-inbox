Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319214AbSIDQFC>; Wed, 4 Sep 2002 12:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319213AbSIDQFC>; Wed, 4 Sep 2002 12:05:02 -0400
Received: from rom.cscaper.com ([216.19.195.129]:35243 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S319202AbSIDQFB>;
	Wed, 4 Sep 2002 12:05:01 -0400
Subject: Re: IDE-DVD problems [excuse former idiotic topic]
Content-Transfer-Encoding: 7BIT
To: Benjamin LaHaise <bcrl@redhat.com>
From: "Joseph N. Hall" <joseph@5sigma.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 4 Sep 2002 09:11 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020904160501Z319202-685+42719@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002 11:49:45 -0400, Benjamin LaHaise <bcrl@redhat.com> wrote:
> On Wed, Sep 04, 2002 at 08:48:00AM -0700, Joseph N. Hall wrote:
> > * Performance is terrible
> > * booting with noapic makes no difference
> > * Performance seems to indicate some kind of difficulties in
> >   the kernel, perhaps connected to interrupt handling
> 
> That's what happens when DMA isn't being used: the kernel spends lots of 
> time copying data from the drive in the interrupt handler and not allowing 
> userspace to execute.

Right, but it will work with or without DMA, for some definition
of "work."  Or it should work, right?

The Sony DVD-ROM performs acceptably w/o DMA (FIC Sabre box w/
1Ghz Pentium, Intel chipset) although it runs faster and smoother
w/ DMA turned on.  Same observation w.r.t CD-ROM.  The LF-D210
(probably it's a D231, they all identify as D210 I think)

Do you know anyone who has gotten this particular drive to work?
Or for that matter if there are any troubles with the KT333
chipset?  I wouldn't be surprised if there are some interrupt
"issues" with KT333 because my plain old IDE performance was
not good under the stock 2.4.18-3 kernel ... it would do some
of the same things (lots of system time, temporary "pauses",
etc.).

I wouldn't mind a m/b change although most of the good
Athlon options are KT333, which probably doesn't
solve anything.  I *was* going to build a dual box with an
S2466 ... maybe I should reconsider doing that.

I am also having problems with the C-Media onboard audio +
ALSA (0.9 rc3) ... it hangs the system (totally) after playing
for a few seconds.  So that is another strike against this
particular h/w configuration.

  -joseph

