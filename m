Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTEQTQU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 15:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTEQTQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 15:16:20 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:28813 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261780AbTEQTQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 15:16:19 -0400
Subject: Re: 2.6 must-fix, v4
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joseph Fannin <jhf@rivenstone.net>
In-Reply-To: <20030517123447.GA31064@shaftnet.org>
References: <20030516161717.1e629364.akpm@digeo.com>
	 <20030516161753.08470617.akpm@digeo.com>
	 <20030517051621.GA10348@rivenstone.net>
	 <20030517123447.GA31064@shaftnet.org>
Content-Type: text/plain
Message-Id: <1053199740.586.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 17 May 2003 21:29:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-17 at 14:34, Stuffed Crust wrote:
> On Sat, May 17, 2003 at 01:16:21AM -0400, Joseph Fannin wrote:
> > On Fri, May 16, 2003 at 04:17:53PM -0700, Andrew Morton wrote:
> > > - synaptic touchpad support
> > > 
> > >   Apparently there's a userspace `tpconfig'
> > 
> >    For 2.4, yes, but the new input layer doesn't allow the raw
> > access to the device needed for tpconfig to frob the touchpads'
> > configuration -- this is the reason for Bugzilla #18.  Vojitech
> > Pavlik said writing support for raw access from userspace wouldn't be
> > much less work than writing the kernel support.
> 
> More important than 'tpconfig' is that the native synaptics drivers for 
> both gpm and XFree86 won't work under 2.5+ either.
> 
> Jens Taprogee has also been working on a Synaptics Input driver.  The 
> main difference in what I have is that his passes the absolute events up 
> to the mousdev layer, which in turn does the heavy lifting.  Much better 
> IMO, as mousedev can get new features which will apply to all 
> absolute-mode touchpads and other input devices.

What about ALPS GlidePoint touchpads? My NEC laptop has one and I miss a
lot the ability to simulate the wheel by dragging the finger over the
edges of the touchpad.

