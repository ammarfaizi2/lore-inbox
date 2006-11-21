Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031363AbWKUXDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031363AbWKUXDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031258AbWKUXDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:03:04 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:13745 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1031363AbWKUXDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:03:02 -0500
Subject: Re: Freeze with ATI Xpress 200
From: Nigel Cunningham <nigelc@bur.st>
Reply-To: nigelc@bur.st
To: Davor Cubranic <cubranic@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c673fbfa0611211417v732f2c0ao2d73f8bf12608768@mail.gmail.com>
References: <c673fbfa0610301216o628ea862jf29fab64a4ba543@mail.gmail.com>
	 <c673fbfa0611211417v732f2c0ao2d73f8bf12608768@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 10:02:57 +1100
Message-Id: <1164150177.27716.8.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davor.

On Tue, 2006-11-21 at 14:17 -0800, Davor Cubranic wrote:
> Just to follow up on my original report: This seems to be a problem
> with running AMD "Cool & Quiet" when using the on-board graphics. (Why
> would Shuttle design an AMD motherboard with a integrated graphics
> which crashes the system if C&Q is turned on? Good question. Shame on
> Shuttle.) I initially reported that Windows worked fine, but although
> I did have AMD CPU driver installed on Windows, C&Q wasn't turned on
> in the "power options" control settings. Once I did that, Windows
> started crashing with the same symptoms as well until I turned it off
> again. I then turned off powernowd in Ubuntu and haven't seen it crash
> since. I'm guessing I never saw this in Gentoo because it did not have
> powernowd activated by default.
> 
> At any rate, this is not a kernel issue, sorry for the trouble.
> 
> Davor
> 
> P.S. I am not on this list, so please email me directly with any
> comments or questions.

Thanks for the email. I didn't notice the first one, but have been
having similar problems with my Turion based laptop that also has a 200M
chipset. I had previously assumed it was a buggy BIOS or something sort
of buffer overrun. I'll try disabling cpufreq support and see if I can
confirm your diagnosis.

Regards,

Nigel

