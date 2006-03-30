Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWC3OSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWC3OSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWC3OSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:18:16 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:16850 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S932221AbWC3OSP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:18:15 -0500
Date: Thu, 30 Mar 2006 16:13:26 +0200 (CEST)
To: artem@ininfo.com.ua, linux-kernel@vger.kernel.org
Subject: Re: i2c
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <080kZhmr.1143728006.0897800.khali@localhost>
In-Reply-To: <442A4498.9060304@ininfo.com.ua>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Thu, 30 Mar 2006 16:13:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Artem,

> Hi. Does anyone now, what has happend. Since kernel 2.6.14 I experience
> problems with kernel:
> 1) I have tvtuner (SAA7134). When switching channels, sound disappear
> for a while and then appear (I think that problem is in trying to found
> stereo), using 2.6.12 it's OK
> 2) My IR (on tvtuner) work worse (have delay,before it begin to react
> on keypress)
> All my suspicions are on i2c

And why that, please?

I am a bit bored by people thinking that any breakage in media/video
drivers must be the fault of i2c. i2c-core is just the core, and it
doesn't change that much these days. Individual drivers are responsible
for their own bugs and breakages.

So, please gather additional data, and report to the v4l volks first. If
they conclude to an i2c problem, they'll let me now. For example,
testing 2.6.13 to know when the breakage occured would be welcome. You
could also enable debug in the faulty drivers and see if anything in the
logs changed between the working case and the broken one.

Additionally, 2.6.14 is a bit old by now. Could you please try with
2.6.16.1? Maybe it's fixed there already.

--
Jean Delvare
