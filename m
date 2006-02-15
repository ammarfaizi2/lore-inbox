Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945989AbWBOPoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWBOPoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWBOPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:44:38 -0500
Received: from [213.91.10.50] ([213.91.10.50]:8408 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1945989AbWBOPoh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:44:37 -0500
Date: Wed, 15 Feb 2006 16:41:39 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: Random reboots
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <6cBigqfP.1140018099.7722170.khali@localhost>
In-Reply-To: <20060215142809.GA17842@tau.solarneutrino.net>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Ryan Richter" <ryan@tau.solarneutrino.net>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Nick Warne" <nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Wed, 15 Feb 2006 16:41:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ryan,

On 2006-02-15, Ryan Richter wrote:
> The sensors report a bunch of obvious nonsesne as always...  I keep them
> configured in with the hope that one day they'll report useful
> information, but that day hasn't come yet.  I just checked, and all the
> fans are still fine.  It's in a huge case with lots of fans and it's
> hardly warmer than room temp.  The opteron 240s don't put out much heat.

The sensors might just need some board-specific configuration. May I ask
which motherboard this is?

I may help you (in private) setup your sensors. If you're interested,
send the output of "sensors-detect" and "sensors" to me and I'll
see what can be done to improve the reported values.

Two more random thoughts:

Any reason why you run 2.6.15 rather than 2.6.15.4? That's where I would
start if I was suspecting a kernel bug.

Did you already update the BIOS to the latest version available? There
are a few kernel complaints in your dmesg which might be solved by a
newer BIOS (and/or parameter changes in the BIOS setup).

--
Jean Delvare
