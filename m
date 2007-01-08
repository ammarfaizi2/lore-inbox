Return-Path: <linux-kernel-owner+w=401wt.eu-S964958AbXAHWCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbXAHWCk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXAHWCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:02:40 -0500
Received: from eazy.amigager.de ([213.239.192.238]:55325 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958AbXAHWCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:02:39 -0500
Date: Mon, 8 Jan 2007 23:02:38 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070108220238.GA16799@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe> <20070107200453.GA3227@thinkpad.home.local> <20070107222706.GA6092@thinkpad.home.local> <20070108161718.GB2208@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108161718.GB2208@elf.ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 17:17:19 +0100, Pavel Machek wrote:
> On Sun 2007-01-07 23:27:06, Tino Keitel wrote:
> > On Sun, Jan 07, 2007 at 21:04:53 +0100, Tino Keitel wrote:
> > > On Sun, Jan 07, 2007 at 13:23:13 -0500, Lee Revell wrote:
> > > > On Sun, 2007-01-07 at 16:17 +0100, Tino Keitel wrote:
> > > > > No information about the device/driver that refuses to resume.
> > > > 
> > > > You should be able to identify the problematic driver by removing each
> > > > driver manually before suspending.
> > > 
> > > I can not reproduce it anymore, resume now works. I really hope that it
> > > will stay so.
> > 
> > It didn't. It looks like it is unusable, becuase it isn't reliable in
> > 2.6.20-rc3.
> 
> What was last working version? Can you pinpoint driver breaking it?

I just used 2.6.18.2 with a manual driven suspend/resume loop and fully
loaded userspace for ca. 40 minutes, without a failure.

I tried to pinpoint the driver with pm_trace, without success (see my
original posting).

Regards,
Tino
