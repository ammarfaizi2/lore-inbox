Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268258AbRG3V0r>; Mon, 30 Jul 2001 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbRG3V0j>; Mon, 30 Jul 2001 17:26:39 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36340 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268233AbRG3V0X>; Mon, 30 Jul 2001 17:26:23 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107302126.f6ULQPi1032424@webber.adilger.int>
Subject: Re: Support for serial console on legacy free machines
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Date: Mon, 30 Jul 2001 15:26:25 -0600 (MDT)
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Khalid Aziz writes:
> I am working on adding support for serial console on legacy free
> machines. Legacy free machines are not expected to have the legacy COM
> ports.

Has anyone considered allowing console devices to run over bi-directional
parallel ports?  I imagine most of the required code is in PLIP and serial,
which unfortunately I know nothing about.

Several newer systems I have today do not have physical serial ports at all,
but all of them (even laptops) still have bi-directional parallel ports.

I suppose there may be some difficulties in exporting a "serial-like"
interface to the user apps (e.g. minicom and such), but maybe not.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

