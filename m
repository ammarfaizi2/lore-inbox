Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVB0HuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVB0HuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 02:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVB0HuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 02:50:04 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:52401 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261364AbVB0Ht6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 02:49:58 -0500
Date: Sun, 27 Feb 2005 08:50:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "Ian E. Morgan" <imorgan@webcon.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALPS tapping disabled. WHY?
Message-ID: <20050227075041.GA1722@ucw.cz>
References: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net> <200502242208.16065.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502242208.16065.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 10:08:15PM -0500, Dmitry Torokhov wrote:

> > So now, can anyone explain what bit 3 of param[0] does, and why you would
> > want to disable hardware tapping support when it's set? My pad (ALPS
> > 56AAA1760C on a Sager NP8560V) has always worked with hardware tapping as a
> > plain PS/2 mouse, no special ALPS support req'd.
> > 
> > Can this disabling of hardware tapping support be made optional (boot time
> > param or other)? I don't want to have to patch every kernel from here on
> > out.
> > 
> 
> It still should do software tap emulation (although support is a bit flakey
> with ALPS I must admit, but there are patches that should improve it) - so
> people who don't like tapping can deactivate it.
> 
> Anyway, "psmouse.proto=exps" boot option should disable ALPS native mode and
> restore previous behavior.

Also, in my tree currently (and planned for 2.6.12) hardware tapping is
enabled again, because double taps don't work otherwise (hardware
limitation).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
