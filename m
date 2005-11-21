Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVKUWhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVKUWhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKUWhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:37:04 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:17940 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751187AbVKUWhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:37:02 -0500
Date: Mon, 21 Nov 2005 23:37:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/7] kconfig/menuconfig
Message-ID: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman & lkml.

I have digged up a serie of patches I had for scripts/lxdialog.
The net result of the patches are much nicer look in a text-only console
(that is with no X running). Also the code becomes in some places
almost readable, using Lindent is just one part of the cure.

Description of the individual patches:

[xxx] Lindent of scripts/lxdialog (patch not posted)
[1/7] fixup after Lindent
[2/7] make lxdialog sparse clean
[3/7] introduce a common helper to simplify printing the title
[4/7] left align the menu lines
[5/7] fix indention on text-only consoles
[6/7] make menubox.c more readable using a single macro
[7/7] truncate long menu lines

All patches are pushed to the kbuild repository at kernel.org:
http://www.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

Patched will follow as reply to this mail

This is not strictly kbuild stuff but using this repository the patches will
hit -mm for wider testing.


	Sam
