Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUJURth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUJURth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270773AbUJURsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:48:41 -0400
Received: from corpmailsmtp02.digitalnetworksna.com ([209.10.223.203]:48378
	"EHLO corpmailsmtp02.digitalnetworksna.com") by vger.kernel.org
	with ESMTP id S270804AbUJURoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:44:24 -0400
Message-ID: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3>
From: John Ripley <jripley@rioaudio.com>
To: "'Greg Buchholz'" <linux@sleepingsquirrel.org>,
       linux-kernel@vger.kernel.org
Subject: RE: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Date: Thu, 21 Oct 2004 10:44:22 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg Buchholz [mailto:linux@sleepingsquirrel.org]
> Sent: 21 October 2004 18:08
> To: linux-kernel@vger.kernel.org
> Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
> 
> Stephen Wille Padnos wrote:
> >I would think that a chip that has a lot of simple functions, but
> >requires the OS to put them together to actually do 
> something, would be
> >great. This would be the UNIX mentality brought to hardware: lots of
> >small components that get strung together in ways their 
> creator(s) never
> >imagined. If there can be a programmable side as well (other than
> >re-burning the FPGA), that would be great.
> >
> >I guess I would look at this as an opportunity to make a "visual
> >coprocessor", that also has the hardware necessary to output to a
> >monitor (preferably multiple monitors).
> 
>     This idea is a step in the right direction.  To make the project
> viable, you might be better off trying to court a slightly different
> audience (instead of the cost-sensitive/3D-performant 
> market).  What if
> instead, you were selling a highly parallel reprogrammable computing
> core, which also happened to do graphics?  I could see a potentially
> much bigger and higher profit margin market for a 
> standardized interface
> from Linux to an FPGA.  Image people buying them for headless 
> servers as
> crypto accellerators.  Or as DSP/FFT accellerators (for speech
> recognition , MPEG compression, or whatever).  I'm sure you'd 
> sell a few
> to grad students writing theses on data flow machines, parallel
> languages, prime factorization etc.  Heck, I'd buy one just 
> because it'd
> be cool to try and write a 1000 element merge sort in hardware that
> completed in one or two clock cycles.  It's not hard to imaging people
> using it to speed up emulators like QEMU.  Maybe the distributed
> computing folks (Folding@Home, SETI) would also be interested, since
> their work is already highly parallelizable.  You get the idea. 
>
>   In my mind, this could be a much better "hook" than the promise of
> openess alone.

It would also really reduce the cost and effort involved in producing the
card. It wouldn't take much (heh) to get it up and running as a simple frame
buffer + blitter, but it could be scaled to do fancy multi-texture ops over
time - all just by reprogramming the FPGA. All the manufacturer needs to
provide is a "getting started" FPGA file and output to a video DAC. The
community would do the rest over time.

I think "Open" hardware is one thing, but open *and* completely
reprogrammable is a far greater hook, at least for me. I'd be prepared to
shell out a few $100 for something as hackable as that. Hey, it's an FPGA on
a PCI Express card at the end of the day, what can't you do with it!

- John Ripley
