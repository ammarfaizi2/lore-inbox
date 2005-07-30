Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbVG3UNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbVG3UNv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVG3ULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:11:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55500 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263157AbVG3UKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:10:55 -0400
Date: Sat, 30 Jul 2005 22:10:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050730201049.GE2093@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122753864.14769.18.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I think this is a good argument for leaving HZ at 1000 until some of
> > > these userspace bugs are fixed.
> > 
> > WTF? HZ=1000 eats energy like crazy. artsd eats energy like crazy. And
> > you advocate breaking kernel because artsd is broken?!
> 
> Maybe I am showing my ignorance as a non-laptop user.  Is 6.67mW a
> really big difference?

First numbers were 0.5W on idle system; that shows what kind of
powersaving can be done. Powersaving is no longer possible when artsd
is not running, but that should not be used as argument against it.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
