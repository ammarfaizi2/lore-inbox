Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbTDBFWI>; Wed, 2 Apr 2003 00:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262972AbTDBFWI>; Wed, 2 Apr 2003 00:22:08 -0500
Received: from 210-86-35-88.dialup.xtra.co.nz ([210.86.35.88]:260 "EHLO
	riven.neverborn.ORG") by vger.kernel.org with ESMTP
	id <S262970AbTDBFWH>; Wed, 2 Apr 2003 00:22:07 -0500
Date: Wed, 2 Apr 2003 17:33:17 +1200
From: "leon j. breedt" <ljb@neverborn.org>
To: linux-kernel@vger.kernel.org
Cc: bcollins@debian.org
Subject: Re: 2.4.21-pre6 and usb-uhci
Message-ID: <20030402053317.GA3341@riven.neverborn.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

after some sleuthing, i found that the file:

usb-Makefile-2.4.21-pre6.patch

located at:

http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/

contains the changes necessary to fix the static build.

it didn't apply cleanly on my stock 2.4.21-pre6, but the changes
are simple enough to add in by hand.

i have it statically compiled into my kernel now and everything's
working fine.

hope this helps.

leon.
