Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDXHKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDXHKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:10:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45959 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261300AbTDXHKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:10:35 -0400
Date: Thu, 24 Apr 2003 08:22:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ben Collins <bcollins@debian.org>
Cc: Pat Suwalski <pat@suwalski.net>, Werner Almesberger <wa@almesberger.net>,
       Pavel Machek <pavel@ucw.cz>, Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424072215.GC28253@mail.jlokier.co.uk>
References: <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz> <3EA71533.4090008@suwalski.net> <20030423225520.GA32577@atrey.karlin.mff.cuni.cz> <20030423231920.D1425@almesberger.net> <3EA74BF1.2090700@suwalski.net> <20030424023434.GF354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424023434.GF354@phunnypharm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> Sound may be a standard feature, but it does not get driven by a
> standard interface like PS2 or HID keyboards do. It's also not as
> straight forward as "sound or no sound". There's many different levels
> of sound hardware, from the 2-channel basic stereo, to the 6-way Dolby
> Digital 5.1.

There was a time when you had to spend a day fiddling with X
configurations to get X to work on your card and monitor.

And then do it again when XFree86 4 came out :(
Or if you changed monitor :(

Thankfully those times are gone, and usually X just works with no
configuration at all.  It's a *huge* improvment.

The same should be possible with sound hardware, however (just as in
the old days of video), sound hardware is mostly not able to
self-configure yet.

> Whether or not a line is needed in an rc script is really a shortcoming
> of userspace, IMO. It's the responsibility of userspace to setup the
> user's environment in the most friendly way.

So why do we enable the PC-speaker beep automatically?
Shouldn't that be silent initially too?

I can tell you that beep can also be quite embarrassing at
conferences.  On my laptop it uses the same speakers as the sound
card, but unfortunately the beep is much louder than I'd even set the
sound to be.

-- Jamie
