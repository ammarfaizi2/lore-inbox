Return-Path: <linux-kernel-owner+w=401wt.eu-S1750724AbXAHX2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbXAHX2H (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbXAHX2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:28:07 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:51484 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbXAHX2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:28:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Date: Tue, 9 Jan 2007 00:29:25 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20070107151744.GA9799@dose.home.local> <20070108161718.GB2208@elf.ucw.cz> <20070108220238.GA16799@dose.home.local>
In-Reply-To: <20070108220238.GA16799@dose.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701090029.25324.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 8 January 2007 23:02, Tino Keitel wrote:
> On Mon, Jan 08, 2007 at 17:17:19 +0100, Pavel Machek wrote:
> > On Sun 2007-01-07 23:27:06, Tino Keitel wrote:
> > > On Sun, Jan 07, 2007 at 21:04:53 +0100, Tino Keitel wrote:
> > > > On Sun, Jan 07, 2007 at 13:23:13 -0500, Lee Revell wrote:
> > > > > On Sun, 2007-01-07 at 16:17 +0100, Tino Keitel wrote:
> > > > > > No information about the device/driver that refuses to resume.
> > > > > 
> > > > > You should be able to identify the problematic driver by removing each
> > > > > driver manually before suspending.
> > > > 
> > > > I can not reproduce it anymore, resume now works. I really hope that it
> > > > will stay so.
> > > 
> > > It didn't. It looks like it is unusable, becuase it isn't reliable in
> > > 2.6.20-rc3.
> > 
> > What was last working version? Can you pinpoint driver breaking it?
> 
> I just used 2.6.18.2 with a manual driven suspend/resume loop and fully
> loaded userspace for ca. 40 minutes, without a failure.
> 
> I tried to pinpoint the driver with pm_trace, without success (see my
> original posting).

Could you please verify if the issue is reproducible when you boot with
init=/bin/bash and suspend with the minimal list of modules loaded?

Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
