Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWGAWU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWGAWU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWGAWU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:20:59 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:63877 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750868AbWGAWU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:20:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Battery-related regression between 2.6.17-git3 and 2.6.17-git6
Date: Sun, 2 Jul 2006 00:21:15 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607020021.15040.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the recent -git on my box (Asus L5D, x86_64 SUSE 10) the powersave
demon is apparently unable to get the battery status, although the data in
/proc/acpi/battery/BAT0 seem to be correct.  As a result, battery status
notification via kpowersave doesn't work and it's hard to notice when the
battery is low/critical.

So far I have verified that this feature works fine with 2.6.17-git3 and
doesn't work with 2.6.17-git6 (-git5 doesn't compile here).

I'll try to get more information tomorrow (unless someone in the know has
an idea of what's up ;-) ).

Greetings,
Rafael
