Return-Path: <linux-kernel-owner+w=401wt.eu-S964984AbWL1Ijk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWL1Ijk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWL1IjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:39:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2863 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964983AbWL1Ii5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:57 -0500
Date: Thu, 28 Dec 2006 08:36:21 +0000
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: How to interpret PM_TRACE output
Message-ID: <20061228083621.GA3955@ucw.cz>
References: <20061213212258.GA9879@dose.home.local> <20061216085748.GE4049@ucw.cz> <20061219085616.GA2053@dose.home.local> <20061220161903.GB4261@ucw.cz> <20061221100101.GA23386@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221100101.GA23386@dose.home.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > developer documentation, and one short paragraph about PM_TRACE that
> > > tells me nothing new. Could you point me to the documentation part that
> > > you are referring to, and that tells me what to do if PM_TRACE shows
> > > the usb device but the failure only occurs when I load the sk98lin
> > > driver?
> > 
> > Hmmm, so it fails somewhere in usb only if sk98lin is loaded? If you
> > unload it again, resume works? Are usb interrupts shared? Where
> 
> Yes, it works with sky2. Yes, the USB device that is reported to fail
> by PM_TRACE shares the interrupt with eth0, which is sk98lin (see my
> original posting in this thread).
> 
> > exactly in the usb does it fail?
> 
> I don't know, all I have is the PM_TRACE output.
> 
> Meanwhile, tried to remove uhci_hcd before suspend, and wakeup works
> then.

Send a nice bug report to usb people, then...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
