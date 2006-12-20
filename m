Return-Path: <linux-kernel-owner+w=401wt.eu-S1030360AbWLTVkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWLTVkt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWLTVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:40:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2794 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030360AbWLTVks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:40:48 -0500
Date: Wed, 20 Dec 2006 16:19:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: How to interpret PM_TRACE output
Message-ID: <20061220161903.GB4261@ucw.cz>
References: <20061213212258.GA9879@dose.home.local> <20061216085748.GE4049@ucw.cz> <20061219085616.GA2053@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085616.GA2053@dose.home.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I tried PM_TRACE to find the driver that breaks resume from suspend.
> > > I got working resume until I switched to the sk98lin driver
> > > (because sky2 doesn't support wake on LAN). That's why I was quite sure that
> > > sk98lin is the culprit, but I tried PM_TRACE anymay.
> > 
> > See Doc*/power/*.
> 
> There is a nice mixture of documentation about swusp, video stuff,
> developer documentation, and one short paragraph about PM_TRACE that
> tells me nothing new. Could you point me to the documentation part that
> you are referring to, and that tells me what to do if PM_TRACE shows
> the usb device but the failure only occurs when I load the sk98lin
> driver?

Hmmm, so it fails somewhere in usb only if sk98lin is loaded? If you
unload it again, resume works? Are usb interrupts shared? Where
exactly in the usb does it fail?
-- 
Thanks for all the (sleeping) penguins.
