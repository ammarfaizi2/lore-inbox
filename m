Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbTDEBFD (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTDEBFC (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:05:02 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:29927 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261608AbTDEBFB (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:05:01 -0500
Date: Sat, 5 Apr 2003 11:16:07 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl, phil@netroedge.com
Subject: Re: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030405011607.GB464@zip.com.au>
References: <20030404021152.GE466@zip.com.au> <20030404171424.GA1380@kroah.com> <20030405005950.GA464@zip.com.au> <20030405011414.GA5697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405011414.GA5697@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 05:14:14PM -0800, Greg KH wrote:
> To a:
> 	tree /sys/bus/i2c/devices/
> to see all of the i2c devices in your system.
> Then go in to the directories of those devices to see the sensor values
> for the devices.

AHA! I was sure I ran find /sys -name '*i2c*'. hrrumph.

> libsensor support will be forthcoming soon for these changes.

Cool. I'll just modify my little script for now. :)

> > One question. Will I need ISA support in the kernel for this?
> 
> Depends, did you need it before?  :)

No. But it made me wonder. :)

> I didn't change any of that logic, just where the information the
> sensors report has moved locations.

Well so far so good. Haven't stressed it yet. Wanted to see that i2c was
actually functioning first. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
