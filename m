Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTAAQQz>; Wed, 1 Jan 2003 11:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTAAQQz>; Wed, 1 Jan 2003 11:16:55 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:29631 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267263AbTAAQQz>; Wed, 1 Jan 2003 11:16:55 -0500
Date: Wed, 1 Jan 2003 17:25:19 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] top-level config menu dependencies
Message-ID: <20030101162519.GF15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It has been a long-time tradition that no "real tunable options" are
present in the top level of the kernel config menu.  I reckon this has
to do with an inherent limitation of the original config subsystem.

While converting the way submenus appear in menuconfig depending on
their main, parent config option, I stumbled upon certain subsystems
(such as MTD or IrDA) that should clearly have an on/off switch directly
in the main menu so that one doesn't have to enter the corresponding
submenus to even see if they're enabled or disabled.

Since the new kernel configurator would have no problems with such
a setup, I'm posting this RFC to get the general opinion on whether
this should be carried on with.  I'm willing to create and send in
the patches.

Regards,
-- 
Tomas Szepe <szepe@pinerecords.com>
