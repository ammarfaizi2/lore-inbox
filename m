Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUJURQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUJURQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbUJURKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:10:25 -0400
Received: from bdsl.66.14.157.209.gte.net ([66.14.157.209]:7659 "EHLO
	greg.sparky.org") by vger.kernel.org with ESMTP id S268752AbUJURIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:08:37 -0400
Date: Thu, 21 Oct 2004 10:08:08 -0700
From: Greg Buchholz <linux@sleepingsquirrel.org>
To: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041021170808.GA675@sleepingsquirrel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Wille Padnos wrote:
>I would think that a chip that has a lot of simple functions, but
>requires the OS to put them together to actually do something, would be
>great. This would be the UNIX mentality brought to hardware: lots of
>small components that get strung together in ways their creator(s) never
>imagined. If there can be a programmable side as well (other than
>re-burning the FPGA), that would be great.
>
>I guess I would look at this as an opportunity to make a "visual
>coprocessor", that also has the hardware necessary to output to a
>monitor (preferably multiple monitors).

    This idea is a step in the right direction.  To make the project
viable, you might be better off trying to court a slightly different
audience (instead of the cost-sensitive/3D-performant market).  What if
instead, you were selling a highly parallel reprogrammable computing
core, which also happened to do graphics?  I could see a potentially
much bigger and higher profit margin market for a standardized interface
from Linux to an FPGA.  Image people buying them for headless servers as
crypto accellerators.  Or as DSP/FFT accellerators (for speech
recognition , MPEG compression, or whatever).  I'm sure you'd sell a few
to grad students writing theses on data flow machines, parallel
languages, prime factorization etc.  Heck, I'd buy one just because it'd
be cool to try and write a 1000 element merge sort in hardware that
completed in one or two clock cycles.  It's not hard to imaging people
using it to speed up emulators like QEMU.  Maybe the distributed
computing folks (Folding@Home, SETI) would also be interested, since
their work is already highly parallelizable.  You get the idea. 

    In my mind, this could be a much better "hook" than the promise of
openess alone.

Here's some people trying to do general purpose computing with current
graphics cards.

http://www.gpgpu.org/
http://graphics.stanford.edu/projects/brookgpu/ 

And be sure to look into existing open hardware projects to see if they
have anything to offer.

http://opencores.org/browse.cgi/by_category


Greg Buchholz

