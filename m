Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbTC0CS5>; Wed, 26 Mar 2003 21:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbTC0CS5>; Wed, 26 Mar 2003 21:18:57 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:31226 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262784AbTC0CS4>; Wed, 26 Mar 2003 21:18:56 -0500
Date: Thu, 27 Mar 2003 14:28:18 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Annouce: Initial SWSUSP 2.4 port to 2.5 available.
To: Swsusp <swsusp@lister.fornax.hu>, Florent Chabaud <fchabaud@free.fr>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1048732097.1731.14.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

It is with delight that I write to announce the first release of the
port of Software Suspend for 2.4 to 2.5. This version has all the
functionality of the 2.4 version beta19-17 - the current development
version for 2.4.  This includes the following enhancements over the
version currently included in the 2.5 kernel:

- HighMem support
- Multiple swap partiton support
- Ability to cancel a suspend by pressing ALT.
- Ability to save what is close a perfect image image of RAM (resulting
in a very fast, responsive system on resume - assumes enough swap
available to store your full image)
- Extensive debugging capabilities
- Fast and reliable (extensive testing done under 2.4).

There are issues still to be dealt with, but these should not in any way
interfere with testing at this stage. They are:

- 2 page flags currently used: to be converted to dynamically allocated
bitmaps
- Interaction with S3 support to be tested and worked on (some common
files affected, S3 support not tested).
- Code cleanups still to be done in some places.

You can find the patch against 2.5.66 on
www.sourceforge.net/projects/swsusp. It's in the swsusp-devel section at
the bottom of the list.

Regards,

Nigel


-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

