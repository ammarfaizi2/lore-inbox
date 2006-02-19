Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWBSUel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWBSUel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWBSUel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:34:41 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:10180 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751041AbWBSUek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:34:40 -0500
Date: Sun, 19 Feb 2006 15:34:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: don't bother users with unimportant messages.
In-reply-to: <20060219082916.GA19903@redhat.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200602191534.38761.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060219010910.GA18841@redhat.com>
 <20060219081523.GA9668@flint.arm.linux.org.uk>
 <20060219082916.GA19903@redhat.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 03:29, Dave Jones wrote:
>On Sun, Feb 19, 2006 at 08:15:23AM +0000, Russell King wrote:
> > On Sat, Feb 18, 2006 at 08:09:10PM -0500, Dave Jones wrote:
> > > When users see these printed to the console, they think
> > > something is wrong.  As it's just informational and something
> > > that only developers care about, lower the printk level.
> >
> > If you're getting complaints about this, wouldn't it be better to
> > forward them here so that they can be fixed up?
>
>w83627hf, and probably other drivers from drivers/hwmon/
>
> > The thing about this particular message is that if you see it, the
> > driver will _not_ work properly, so it's actually more than a
> > "debugging" message.  It's telling you why driver FOO doesn't work.
>
>I'm pretty certain this driver _was_ working fine before this change.
>
>  Dave
I got an advisory about w83627hf in my logs, but not from the rc4 
reboot.  The previous ones were:
Feb 13 00:31:18 coyote kernel: Driver 'w83627hf' needs updating - please 
use bus_type methods
Feb 13 00:36:20 coyote kernel: Driver 'w83627hf' needs updating - please 
use bus_type methods

Two quick reboots there, the first one would have been rc2, I forgot to 
update grub.conf :(

which would have been booted to rc2 and 3, not rc4. I believe they 
started at rc1 but I won't swear to that.  gkrellm and sensors are both 
working albeit sensors is saying C for the diode in the cpu when it 
should be F

gkrellm-2.28 is displaying it correctly though.

So apparently something has been updated with rc4?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
