Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVLBF3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVLBF3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 00:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVLBF3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 00:29:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:8415 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751315AbVLBF3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 00:29:10 -0500
Message-ID: <438FDB9D.2030201@pobox.com>
Date: Fri, 02 Dec 2005 00:29:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA oops
References: <20051202045853.GD3677@vitelus.com>
In-Reply-To: <20051202045853.GD3677@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Aaron Lehmann wrote: > I'm running 2.6.14.2 on an
	x86_64 (Athlon X2, i.e. SMP) with a Promise > TX4 SATAII 150
	controller. The night I set up the machine, I got a > Promise-related
	oops (null pointer dereference IIRC), but was foolish > enough not to
	write it down. Since then, the machine has been > unstable, and I've
	suspected the same thing is recurring, but since I > use X it's very
	difficult to actually get at the oops. I ended up > setting up a
	ramdisk with a static busybox that I could use to poke > around if
	anything interesting happened. Just now everything using the >
	filesystem went into D-state, so I checked dmesg and saw uncorrectable
	> errors being reported on /dev/sdd. The system froze completely within
	> a minute. When I rebooted, I got the oops at the end of this message.
	> I was only able to copy the portion that fit on the screen. A second
	> reboot was sucessful. My RAID5 arrays are resyncing now, and I expect
	> that to complete normally because I've had to go through a lot of >
	resyncs since I set this system up and they were all sucessful. Once >
	that's done, I guess I'll run badblocks on sdd and see if anything >
	turns up. It would be a shame if that drive is bad, considering that >
	my 4 hard drives are brand new ones to replace a failed array I had >
	lots of problems with. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> I'm running 2.6.14.2 on an x86_64 (Athlon X2, i.e. SMP) with a Promise
> TX4 SATAII 150 controller. The night I set up the machine, I got a
> Promise-related oops (null pointer dereference IIRC), but was foolish
> enough not to write it down.  Since then, the machine has been
> unstable, and I've suspected the same thing is recurring, but since I
> use X it's very difficult to actually get at the oops. I ended up
> setting up a ramdisk with a static busybox that I could use to poke
> around if anything interesting happened. Just now everything using the
> filesystem went into D-state, so I checked dmesg and saw uncorrectable
> errors being reported on /dev/sdd. The system froze completely within
> a minute. When I rebooted, I got the oops at the end of this message.
> I was only able to copy the portion that fit on the screen. A second
> reboot was sucessful. My RAID5 arrays are resyncing now, and I expect
> that to complete normally because I've had to go through a lot of
> resyncs since I set this system up and they were all sucessful. Once
> that's done, I guess I'll run badblocks on sdd and see if anything
> turns up. It would be a shame if that drive is bad, considering that
> my 4 hard drives are brand new ones to replace a failed array I had
> lots of problems with.

This should be fixed in 2.6.15-rcX...

	Jeff



