Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSG1PxK>; Sun, 28 Jul 2002 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSG1PxK>; Sun, 28 Jul 2002 11:53:10 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:47990 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S316544AbSG1PxJ>;
	Sun, 28 Jul 2002 11:53:09 -0400
Date: Sun, 28 Jul 2002 17:56:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
Message-ID: <20020728155626.GC26862@win.tue.nl>
In-Reply-To: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <20020727235726.GB26742@win.tue.nl> <20020728024739.GA28873@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 07:47:39PM -0700, Greg KH wrote:

> On Sun, Jul 28, 2002 at 01:57:26AM +0200, Andries Brouwer wrote:
> > My third candidate is USB. Systems without USB are clearly more stable.
> 
> Hm, then that would imply that all of my systems are unstable :)
> 
> Seriously, I don't know of any outstanding 2.5 USB issues that cause
> oopses right now, or effect stability.  Any problems that people are
> having, they sure are not telling me, or the other USB developers
> about...

I reported an oops at shutdown and provided the trivial fix.
It is the the standard kernel since 2.5.26, I think.

But there are still other oopses at shutdown for 2.5.27.

For 2.5.29 I reported
"> I booted 2.5.29 earlier this evening and was greeted by
 > kernel BUG at transport.c: 351 and
 > kernel BUG at scsiglue.c: 150.
 > (And the usb-storage module now hangs initializing; rmmod fails,
 > reboot is necessary.)"

Further improvement of usb-storage is possible.

Andries
