Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272277AbTG3Voh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272287AbTG3Voh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:44:37 -0400
Received: from pc2-rdng1-4-cust24.winn.cable.ntl.com ([80.3.251.24]:50267 "EHLO
	purplet.home.jaggycraft.co.uk") by vger.kernel.org with ESMTP
	id S272277AbTG3Vof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:44:35 -0400
Message-ID: <3F283C41.1070301@purplet.demon.co.uk>
Date: Wed, 30 Jul 2003 22:44:33 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-gb, en, fr, de
MIME-Version: 1.0
To: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
Cc: Kent Borg <kentborg@borg.org>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
References: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk> <20030729172035.D6570@borg.org> <20030729214404.GB21517@bodmin.doc.ic.ac.uk>
In-Reply-To: <20030729214404.GB21517@bodmin.doc.ic.ac.uk>
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strangely (and perhaps sadly) enough a couple of years ago I wrote
an LED, um, "pattern generator" because, ah, someone insisted that
it would be "really cool" if the kit we were (going to) build had
a Knight Rider / Cylon "sweep"...

It had drivers for parport (I did initial development using LEDs
hanging off the back of a Thinkpad), a 5.25" SBC made by WinEnt
(LEDs on the PIIX4 GPO pins), an i2c I/O chip (used in the semi-custom
PC we eventually chose), and a test stub that just output bit patterns.

Since running patterns from user space is anti-social (and it's
difficult to get the timing good enough) there was a kernel space
"interpreter" that you could load scripts in to. Sweeps, scans,
blinks, ping-pong etc. Plus you could have multiple scripts with
LEDs "owned" by different scripts so you could do knock outs,
fill ins etc. And, of course, change scripts to reflect system
status on the fly :-)

Ok, it was a sunday afternoon hack so I got carried away a bit...

Like I say it was a couple of years ago so it probably needs some
work. But I'm quite happy to mail it to anyone that's curious. And
if any hardware manufacturers still think sweeping LEDs are cool
and trendy they're welcome to talk to me. Discreetly :-).

Mike

-- 
Mike Jagdis
Eris Associates Limited

