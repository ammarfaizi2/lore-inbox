Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUALRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266229AbUALRF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:05:58 -0500
Received: from mxsf25.cluster1.charter.net ([209.225.28.225]:37902 "EHLO
	mxsf25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S266225AbUALRFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:05:54 -0500
Subject: Re: Laptops & CPU frequency
From: Jerry Cooperstein <jerry.cooperstein@charter.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073817226.6189.189.camel@nomade>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1073926718.10953.8.camel@p3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 10:58:39 -0600
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were some patches to solve this back in the 2.5 series.

Try booting with the kernel command line option
          clock=pit

coop@axian.com

On Sun, 2004-01-11 at 04:33, Xavier Bestel wrote:
> Le dim 11/01/2004 à 11:27, Xavier Bestel a écrit :
> 
> > > The MHz value in /proc/cpuinfo should be updated as the CPU speed
> > > changes - that is, it is not calculated just at boot, but it is updated
> > > as the speed actually changes.
> > 
> > 2.6.0 doesn't do that on my laptop. Moreover, if I ever boot on battery,
> > when switching to AC power, lots of things fail (mouse is jerky, pcmcia
> > doesn't work ...)
> 
> I forgot one particularly annoying too: time is going twice too fast.
> 
> 	Xav
======================================================================
 Jerry Cooperstein, <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================


