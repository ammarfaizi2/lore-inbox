Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVL0P5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVL0P5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 10:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVL0P5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 10:57:25 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:29088 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1751119AbVL0P5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 10:57:25 -0500
Date: Tue, 27 Dec 2005 10:57:16 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
In-Reply-To: <200512271545.31224.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
 <200512270149.24440.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
 <200512271545.31224.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have it working in X.org with no problem.  I just can't get the drm
module working in the kernel.  Last time I tried to just add my PCI ids 
the problem was a lack of PCIE support in the drm drivers. 

FYI the fglrx drivers suck badly.  ATI hasn't bothered to keep their 
drivers up to date at all and the result is that they finally have  
working 2.6.14 drivers but only for 32 bit machines.  x86_64 is still 
broken on any recent kernel and it's been that way for months.  ATI's tech 
support basically gave up after several days and just informed me it 
wasn't really supported and there is nothing they could do for me.

	Gerhard

On Tue, 27 Dec 2005, Alistair John Strachan wrote:

> Date: Tue, 27 Dec 2005 15:45:31 +0000
> From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
> To: Gerhard Mack <gmack@innerfire.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: ati X300 support?
> 
> On Tuesday 27 December 2005 13:17, Gerhard Mack wrote:
> > The raedon drm module does not seem to detect the card.
> 
> Try finding the place where the supported PCI ids are written, and add your 
> card's PCI ID. If the DRM module successfully detects your card, email the 
> maintainers with the information (and ideally a patch which adds this 
> information).
> 
> I don't know for sure, but according to this page:
> 
> http://dri.freedesktop.org/wiki/ATIRadeon#head-cef41521e55884edc9cd417b42fb2b8b4fcda672
> 
> "X300 denotes a rv370 based card."
> 
> This may imply that the r300 driver is useable with this hardware.
> 
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
