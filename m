Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbTDEBeo (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTDEBeo (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:34:44 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:64231 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261674AbTDEBen (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:34:43 -0500
Date: Sat, 5 Apr 2003 11:45:34 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl, phil@netroedge.com
Subject: Re: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030405014533.GA444@zip.com.au>
References: <20030404021152.GE466@zip.com.au> <20030404171424.GA1380@kroah.com> <20030405005950.GA464@zip.com.au> <20030405011414.GA5697@kroah.com> <20030405011607.GB464@zip.com.au> <20030405012414.GA5532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405012414.GA5532@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 05:24:14PM -0800, Greg KH wrote:
> > Cool. I'll just modify my little script for now. :)
> 
> Great.  Can you validate that the output of the sysfs files is in the
> proper units (should be milliVolts and milliCelcius)?  I am pretty sure
> I got this one wrong, as I don't have the hardware to test it on.

I don't think I saw any. From memory there was temp info, power, on_die
and one or two other things (alarm maybe). This is from memory thoguh as
the kernel died during my compiling the kernel, mplayer and using
mozilla. Symptoms as before.

Current -bk10 kernel servived that.  Differences are:

+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_PIIX4=y
+CONFIG_SENSORS_ADM1021=y
+CONFIG_I2C_SENSOR=y

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
