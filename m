Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWHIM1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWHIM1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWHIM1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:27:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8416 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750701AbWHIM1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:27:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Wed, 9 Aug 2006 14:26:31 +0200
User-Agent: KMail/1.9.3
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091426.31762.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like the CMOS clock gets corrupted during the suspend to disk
on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
AMD64-based and the x86_64 kernel doesn't have this problem on it.

Also, I've done some tests that indicate the corruption doesn't occur before
saving the suspend image.  It rather happens when the box is powered off
or rebooted (tested both cases).

Unfortunately, I have no more time to debug it further right now.

Greetings,
Rafael
