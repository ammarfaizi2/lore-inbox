Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSK1VG3>; Thu, 28 Nov 2002 16:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSK1VG3>; Thu, 28 Nov 2002 16:06:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266682AbSK1VG2>; Thu, 28 Nov 2002 16:06:28 -0500
Date: Thu, 28 Nov 2002 21:13:47 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: connectivity to bkbits.net?
Message-ID: <20021128211347.D27234@flint.arm.linux.org.uk>
Mail-Followup-To: Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
References: <200211281625.gASGPo804227@work.bitmover.com> <8aiMdRMXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8aiMdRMXw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Thu, Nov 28, 2002 at 06:53:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 06:53:00PM +0200, Kai Henningsen wrote:
> >From two or three traceroutes, that problem seems to be at the SGI end. I  
> can't get to them either (nothing after the same IP as for you, at hop  
> #17, some place at Genuity), but you are practically next door.

Lesson #1 of firewalling: drop everything.
Lesson #2 of firewalling: only accept what you absolutely have to.

Try pointing a web browser at sgi.com port 80.  I _bet_ you get a
response.  The site is reachable, they just block UDP (and probably
a lot of other stuff.)

traceroute uses UDP, so if a site drops UDP (rather than blocking it)
it will appear as a black hole.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

