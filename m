Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289639AbSAJThu>; Thu, 10 Jan 2002 14:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289630AbSAJThj>; Thu, 10 Jan 2002 14:37:39 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:43762 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289634AbSAJThX>;
	Thu, 10 Jan 2002 14:37:23 -0500
Date: Thu, 10 Jan 2002 20:36:55 +0100
From: David Weinehall <tao@acc.umu.se>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020110203655.H5235@khan.acc.umu.se>
In-Reply-To: <E16OUu0-00035o-00@the-village.bc.nu> <200201101753.g0AHrlA17591@snark.thyrsus.com> <3C3DDEA9.E8FAB8DC@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3DDEA9.E8FAB8DC@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Jan 10, 2002 at 01:34:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 01:34:17PM -0500, Chris Friesen wrote:
> Rob Landley wrote:
> 
> > And a sound card with only 1mS of buffer in it is definitely not useable on
> > windoze, the minimum buffer in the cheapest $12 PCI sound card I've seen is
> > about 1/4 second (250ms).  (Is this what you mean by "hardware fun"?)  Even
> > if the app was taking half that, it's still a > 100ms big gap where the OS
> > leaves it hanging before you get a dropout.  (Okay, some of that's watermark
> > policy, not sending more data to the card until half the buffer is
> > exhausted...)  What sound output device DOESN'T have this much cache?
> 
> Imagine taking an input, doing dsp-type calculations on it, and sending it back
> as output.  Now...imagine doing it in realtime with the output being fed back to
> a monitor speaker.  Think about what would happen if the output of the monitor
> speaker is 1/4 second behind the input at the mike.  Now do you see the
> problem?  A few ms of delay might be okay.  A few hundred ms definately is not.
> 
> > Now VIDEO is a slightly more interesting problem.  (Or synchronizing audio
> > and video by sending really tiny chunks of audio.)  There's no hardware
> > buffer there to cover our latency sins.  Then again, dropping frames is
> > considered normal in the video world, isn't it? :)
> 
> If I'm trying to watch a DVD on my computer, and assuming my CPU is powerful
> enough to decode in realtime, then I want the DVD player to take
> priority--dropping frames just because I'm starting up netscape is not
> acceptable.

Ummm, and you couldn't consider refraining from firing up Netscape
while watching the DVD, could you?!

I get your point, but the example was poorly chosen, imho.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
