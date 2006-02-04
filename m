Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWBDUyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWBDUyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWBDUyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:54:00 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:59059 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964827AbWBDUx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:53:59 -0500
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: S3 sleep regression / 2.6.16-rc1+acpi-release-20060113 
In-Reply-To: Your message of "Sat, 04 Feb 2006 17:12:25 +1000."
             <200602041712.30428.ncunningham@cyclades.com> 
Date: Sat, 04 Feb 2006 20:53:55 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1F5UPr-0008FN-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After the first suspend, do you have any processes sucking all
> available cpu? This sounds like a thread that has been added since
> 2.6.15, which is being told to enter the freezer, but isn't doing
> it. They usually end up sucking cpu afterwards.

A good thought.  I just tried it again.  The system woke up from the
first S3 sleep with nothing chewing CPU.  Just as a check, the second
S3 sleep still hangs with the repeating exregion-* messages.

I also tried vanilla 2.6.16-rc2 (which includes the latest ACPICA
releases in it), and it has the same problem.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
