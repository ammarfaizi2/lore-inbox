Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUAJTpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbUAJTpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:45:49 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:6528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265379AbUAJTp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:45:27 -0500
Date: Sat, 10 Jan 2004 20:46:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, vojtech@suse.cz
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110194655.GB1212@elf.ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <200401101428.49358.dtor_core@ameritech.net> <20040110194040.GA24318@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110194040.GA24318@joshua.mesa.nl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> > > is not really suitable to be enabled by default. You can not click by
> > > tapping the touchpad (well, unless you have very new X with right
> > > configuration, but than you can't go back to 2.4),
> > 
> > It is my understanding that by setting "Protocol" to "auto-dev" and
> > "Device" to "/dev/psaux" you can freely switch between 2.4 and 2.5.
> 
> I work with this setting for a couple of weeks now switching between 2.4
> and 2.6. The touchpad works quite well in X. (Dell inspiron 8000).
> I only notice I have to tap harder to get a click.

Is there way to make it work with gpm, too? I'm using that
heavily. Currently I'm doing gpm in repeater mode, then X reading from
/dev/gpmdata....
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
