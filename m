Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290138AbSAKWNp>; Fri, 11 Jan 2002 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290137AbSAKWNg>; Fri, 11 Jan 2002 17:13:36 -0500
Received: from svr3.applink.net ([206.50.88.3]:21265 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290136AbSAKWN2>;
	Fri, 11 Jan 2002 17:13:28 -0500
Message-Id: <200201112211.g0BMAqSr004343@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: brian@worldcontrol.com, Christiaan Kok <chrkok@chem.rug.nl>
Subject: Re: Kernel 2.4.17 gets really slow when handling large files
Date: Fri, 11 Jan 2002 16:06:44 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m16OyYV-000t5oC@polypc17.chem.rug.nl> <20020111215650.GA2943@top.worldcontrol.com>
In-Reply-To: <20020111215650.GA2943@top.worldcontrol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 15:56, brian@worldcontrol.com wrote:
> On Fri, Jan 11, 2002 at 11:04:59AM +0100, Christiaan Kok wrote:
> > Dear people,
> >
> > I have a problem with kernel 2.4.17 and as far as I have testen all the
> > 2.4.X kernels before it. When handling large files, like moving or
> > viewing movies (700 Mb) (with mplayer) my system suddenly slows down a
> > lot. This can only be repaired by a reboot. hdparm -Tt /dev/hdX values
> > drop from around 25 MB/s to around 8 MB/s but DMA is still on (at least
> > that is what hdaprm reports). In is a such a state it is imposible to
> > burn cds for instance but networkspeed is unharmed.
>
> How slow?  Does it always happen when playing large files with mplayer
> or only some of the time?
>
> I've run into a similar sounding problem.
>
> Running mplayer, sometimes, perhaps 1 to 50 runs, the system becomes
> nearly unresponsive.  I can switch virtual desktops in X, via WM,
> promptly.  Through redraws of the switched-to desktop are slow.
>
> xmms playing music continues to play fine.
>
> rxvt's have about a 4 second response time.
>
> Generally, I can manage rebooting the laptop.
>
> Originally I blamed low-latency patches, and have switch back to
> 2.4.17 with preempt-patch.

I'm assuming that you have checked to make sure that your system
hasn't run out of memory and is swapping heavily.   If mplayer had
a memory leak this could be the expected behaviour.  [when in X,
I usually keep xosview or some similar meter open so that I can
see cpu, memory, and swap usage.]

-- 
timothy.covell@ashavan.org.
