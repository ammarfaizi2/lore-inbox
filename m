Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbRDRS6l>; Wed, 18 Apr 2001 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135259AbRDRS6b>; Wed, 18 Apr 2001 14:58:31 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:11480 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S135256AbRDRS6R>; Wed, 18 Apr 2001 14:58:17 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDD9B@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Martin Hamilton'" <martin@net.lut.ac.uk>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux 2.4.3-ac7 
Date: Wed, 18 Apr 2001 11:54:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin Hamilton [mailto:martin@net.lut.ac.uk]
> | ACPI is meant to abstract the OS from all the "magic 
> numbers". It's very
> | possible to do things in a platform-specific way, but if 
> you want to handle
> | all platforms, you'd end up with something ACPI-like.
> 
> This isn't me talking, but I think you know the objection from
> hardcore Linux folk is essentially that Linux is the only platform for
> which platform-specific stuff should go into the Linux kernel.  I
> don't really mind so long as suspend-to-disk and resume work... ;-)

I don't think I understand that first sentence. (Let me respond anyways ;-)
As of now, the Linux kernel is not so platform-specific that you need
different kernel images for different BIOS revisions, or different
motherboard layouts. When you start putting platform magic numbers in the
kernel config, this is the result, and this is the *worst* possible outcome.

ACPI lets the OS manage the platform by determining this stuff at run-time
(as opposed to compile-time) so one kernel can handle all platform
configurations.

> | We're working on this. The major issue now is device power 
> management. 
> 
> I was wondering whether the swsusp work might form a useful basis for 
> the eventual ACPI implementation of the to-disk hibernation stuff:

I (and others) have looked at it. It's a pretty cool patch, but it really
isn't the right way to do things.

Regards -- Andy

