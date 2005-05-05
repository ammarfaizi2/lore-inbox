Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVEEWHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVEEWHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 18:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVEEWHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 18:07:54 -0400
Received: from quechua.inka.de ([193.197.184.2]:56498 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261963AbVEEWHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 18:07:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Exploit in 2.6 kernels
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no> <20050413125921.GN17865@csclub.uwaterloo.ca> <425E6627.9080405@aitel.hist.no>
Organization: private Linux site, southern Germany
Date: Fri, 06 May 2005 00:00:47 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1DToOl-0005iV-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have the impression that 2D is fine with ATI cards, even those
> that doesn't have open 3D drivers.  And even a really old low-end
> card performs fine for 2D work.  Even the unaccelerated
> framebuffer drivers seems to have enough performance
> for 2D in most cases. The cpu is fast these days. :-)

Not quite. The _perceived_ difference e.g. between unaccelerated fbdev
and mga driver is dramatic when you scroll around much in your windows
(of eclipse, mozilla...) even on 3 GHz CPUs. (I know very well since I
had to live with fbdev on a G550 for some time...)
And for video acceleration, there's always the point where it makes
the difference between stuttering and no stuttering.

I won't use any non-accelerated basic X11 and non-accelerated Xv any
more, no matter how fast the CPUs get. (The fact that it was always
worse n years ago for bigger n doesn't count...)

Olaf

PS. The most important feature of any graphics card for me? No fan.

