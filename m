Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVJQQax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVJQQax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVJQQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:30:53 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:54259 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S1750709AbVJQQaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:30:52 -0400
Date: Mon, 17 Oct 2005 18:30:40 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: <linux-kernel@vger.kernel.org>, <bob.picco@hp.com>
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
In-Reply-To: <20051014193025.653886f0.rdunlap@xenotime.net>
Message-ID: <Pine.HPX.4.33n.0510171821290.18920-100000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scan-Signature: 1dcf858e5f71d201888bc25046ce534d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> On Tue, 04 Oct 2005 14:41:26 +0200 (MEST) Clemens Ladisch wrote:
>
> > Another round of HPET bugfixes and cleanups.
>
> I've applied and tested all of these along with what is
> currently in -mm (only -mm hpet + timer patches).
>
> By "tested" I mean that I booted the kernel.  :)
>
> What kind of testing have you done?
> Do you have any timer test tools that you use to verify that
> timers are actually working as expected?

Apart from the test program in hpet.txt, I'm using the ALSA HPET
driver (contained in the ALSA 1.0.9 package, but not yet in the kernel
tree) and then just test it using the ALSA API and/or use it as the
MIDI sequencer timer.


HTH
Clemens

