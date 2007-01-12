Return-Path: <linux-kernel-owner+w=401wt.eu-S1161134AbXALWXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbXALWXf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXALWXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:23:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4891 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161134AbXALWXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:23:34 -0500
Date: Fri, 12 Jan 2007 14:50:25 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Luming Yu <luming.yu@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070112145025.GB7685@ucw.cz>
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe> <20070107200453.GA3227@thinkpad.home.local> <20070107222706.GA6092@thinkpad.home.local> <20070107234445.GM20714@stusta.de> <20070108210428.GA7199@dose.home.local> <3877989d0701090651m84d7f41v5d06e1638a7eb31d@mail.gmail.com> <20070109231655.GA5958@thinkpad.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109231655.GA5958@thinkpad.home.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> > It didn't. It looks like it is unusable, becuase it isn't reliable in
> > >> > 2.6.20-rc3.
> > >>
> > >> Is this issue still present in -rc4?
> > >
> > >I used 2.6.20-rc4 in single user mode, and applied 2 patches from
> > >netdev to get wake on LAN support. This way I was able to set up an
> > >automatic suspend/resume loop. It looked good, but after e.g. 20
> > >minutes, the resume hang. So it is reproduceable with 2.6.20-rc4.
> > >Unfortunately, I can not test the same with 2.6.18, as the wake on LAN
> > >patches need 2.6.20-rc.
> > 
> > Hmm, do you mean this is the first time of this kind of testing?
> > Is this issue related to LAN driver?
> > I guess you should be able to set up an automatic suspend/resume loop
> > with /proc/acpi/alarm, and test similar with 2.6.18.
> 
> Thanks for the hint. I just used /proc/acpi/alarm to set up a
> suspend/resume loop and did ca. 100 cycles in a row with 2.6.18.2 in
> single user mode, without a failure.

Can you do similar test on 2.6.20 -- w/o network driver loaded (and
generaly minimum drivers?)
							Pavel

-- 
Thanks for all the (sleeping) penguins.
