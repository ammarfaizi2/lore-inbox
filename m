Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUJVRc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUJVRc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUJVR0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:26:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38671 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267195AbUJVRTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:19:49 -0400
Message-ID: <41794406.5010707@techsource.com>
Date: Fri, 22 Oct 2004 13:31:50 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Christian Leber <christian@leber.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <Pine.LNX.4.60.0410201521310.17443@dlang.diginsite.com> <4177CBD5.2030003@techsource.com> <20041022101648.GA4287@core.home>
In-Reply-To: <20041022101648.GA4287@core.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Leber wrote:
> On Thu, Oct 21, 2004 at 10:46:45AM -0400, Timothy Miller wrote:
> 
> 
>>I've just had a discussion with our senior ASIC designer, and we came up 
>>with ball-park numbers for the cost of a first run of boards in a 
>>quantity of 1000.
>>
>>FPGA              Anywhere from $50 to $500, depending on logic area
> 
> 
> About what FPGA are you thinking?

At the time, I do not have an estimate for the logic area required for a 
3D design.

I don't even know what size FPGA would be required to hold the logic 
that is in the graphics ASIC I (mostly I) designed for our ATC products. 
  It's a high-performance 2D engine designed more for driving high-res 
displays (2048x2048, 2560x2048, 3840x2400, etc.) than for fast 
rendering, although it is very fast, and it's designed to be efficient 
at all of the things that an ATC system needs to render.  Anyhow, as a 
benchmark, I asked our senior ASIC guy what size FPGA would be required 
to hold it.  He's going to get back with me on that.

In any event, whatever that is, we'll need several times that for a fast 
3D core.

> And you have to add the cost for PCI express support... will PCI express
> even work on such a small FPGA?

There are already Xilinx chips that have PCI express support in them. 
For AGP and PCI, I would just take the PCI core for our existing design 
and modify it for the new purpose.

