Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTBJPdW>; Mon, 10 Feb 2003 10:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTBJPdW>; Mon, 10 Feb 2003 10:33:22 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:8658 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S264665AbTBJPdV>; Mon, 10 Feb 2003 10:33:21 -0500
Date: Mon, 10 Feb 2003 16:43:04 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dan Parks <Dan.Parks@CAMotion.com>
Cc: SA <no_spam@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt latency ?
Message-ID: <20030210154304.GA1973@wohnheim.fh-wedel.de>
References: <200302071850.52781.no_spam@ntlworld.com> <20030210135822.GA14827@wohnheim.fh-wedel.de> <1044889126.1438.460.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1044889126.1438.460.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 February 2003 09:58:46 -0500, Dan Parks wrote:
> 
> Do you happen to have a program (or kernel module...) that times these
> latencies?  I've been trying to generate statistics about these kinds of
> latencies, and have yet to be happy with any of my tests.

That should be impossible to do. :)

Write a simple handler for parport or so, that is called when line #1
toggles from low to high and responds by pulling line #2 from low to
high.
Now hook up a signal generator and an oszilloscope and measure the
time from signal generation to the physical reaction.

This way you get all the latency, not just the small amount you can
measure inside the kernel.

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
