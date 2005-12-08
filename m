Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVLHTiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVLHTiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVLHTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:38:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34703 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932272AbVLHTiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:38:14 -0500
Subject: Re: AW: Re: Linux in a binary world... a doomsday scenario
From: Lee Revell <rlrevell@joe-job.com>
To: dirk@steuwer.de
Cc: rdunlap@xenotime.net, wli@holomorphy.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, arjan@infradead.org, diegocg@gmail.com
In-Reply-To: <6798653.142371134056986823.JavaMail.servlet@kundenserver>
References: <6798653.142371134056986823.JavaMail.servlet@kundenserver>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 14:38:02 -0500
Message-Id: <1134070683.3919.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 16:49 +0100, dirk@steuwer.de wrote:
> Yes, i can see the problem.
> How about interconnecting it with the bugtracker?
> If there is a bug, and if it is related to some hardware, it is logged
> in the database as broken for that kernel version. If the bug is
> fixed, support status is ok again.
> All that needs to be done is entering the device once into the
> database, status is broken by default, and take it from there?
> Then it gets some goals (similar to bugs) assigned if it is a complex
> device. i.e. for a graphic device:
> * 2d graphic support
> * 3d graphic support
> * framebuffer
> * vesa 

This is a grave oversimplification of how it would work.  Look at sound
hardware, vendors come out with new devices so fast that it would be a
full time job to keep that ALSA wiki 100% accurate.  At least half the
bugs that users report aren't real bugs.  There are gazillions of small
variations of the same device.  Vendors are deceptive at best and lie
through their teeth at worst.  A "Sound Blaster Live! SB0410" could use
a COMPLETELY different and VASTLY inferior chipset to a "Sound Blaster
Live! SB0350".  They release two devices with identical PCI ids but
different hardware.  And they don't tell us word one about their plans.
Often the users know a lot better than the developers do what devices
are supported to what degree.  Etc.

If we followed your scheme 95% of supported hardware would be listed as
broken.

Lee 

