Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTAEXLE>; Sun, 5 Jan 2003 18:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbTAEXLE>; Sun, 5 Jan 2003 18:11:04 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:36591 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265532AbTAEXLD>;
	Sun, 5 Jan 2003 18:11:03 -0500
Date: Sun, 5 Jan 2003 18:19:21 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net
Cc: hermes@gibson.dropbear.id.au, dhinds@sonic.net
Subject: [PATCH] orinoco_plx-0.13b backport to kernel 2.2
Message-ID: <20030105231921.GA7294@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've backported David Gibson's orinoco_plx wireless driver to kernel 2.2.
The port is based on David Hinds's pcmcia-cs package. I've been running
various versions of this backport for over a year now and it has been
working well. I've updated it to the latest (testing, beta) version of
the orinoco_plx driver (0.13b) and the latest version of pcmcia-cs (3.2.3).

The patch comes in two parts. The first part updates the version of
orinoco, hermes, and orinoco_cs modules in pcmcia-cs-3.2.3 from 0.11b to
0.13b. The second part adds the backported orinoco_plx module. After
applying both patches, configure, build, and install pcmcia-cs as normal
and you should have an additional orinoco_plx.o module ready to use.

Patches are rather large so I've put them online here:

http://www.kroptech.com/~adk0212/pcmcia-cs-3.2.3-update-orinoco-0.13b.patch
http://www.kroptech.com/~adk0212/pcmcia-cs-3.2.3-add-orinoco_plx-0.13b.patch

--Adam

