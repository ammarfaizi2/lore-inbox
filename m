Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275401AbTHNRYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275406AbTHNRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:24:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16136 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275401AbTHNRYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:24:12 -0400
Date: Thu, 14 Aug 2003 18:24:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: John Levon <levon@movementarian.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030814182403.E332@flint.arm.linux.org.uk>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org> <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk> <20030814165512.GA36329@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030814165512.GA36329@compsoc.man.ac.uk>; from levon@movementarian.org on Thu, Aug 14, 2003 at 05:55:12PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 05:55:12PM +0100, John Levon wrote:
> On Thu, Aug 14, 2003 at 05:47:03PM +0100, Alan Cox wrote:
> 
> > I see no problem with it either going or becoming an arch specific
> > module someone can go write if they care about it and insmod if they
> > actually use.
> 
> And then I'm stuck with no sensible way to figure out the kernel pointer
> size again... all user-space suggestions having the problems listed
> in this thread :
> 
> http://marc.theaimsgroup.com/?t=104205635900001&r=1&w=2

You could say "oprofile requires /proc/kcore support".

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

