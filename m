Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWGYG5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWGYG5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWGYG5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:57:04 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:46296 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751464AbWGYG5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:57:01 -0400
Date: Tue, 25 Jul 2006 08:56:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [PATCH v2 0/3] kconfig/lxdialog: color theme support
Message-ID: <20060725065640.GA2685@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second iteration of the patchset to add color theme support to lxdialog.
This patchset allow the menuconfig user to select between a number of
different color themes for menuconfig:
blackbg, classic, mono and bluetitle

The latter is the default after applying this patchset.
To select a color theme use:
make MENUCONFIG_COLOR=blackbg menuconfig

Changes since v1 of the patchset:
o Initial refactoring are now done so mono and classic are independent
o Renamed global variable to 'dlg' - the one containing the color
  definitions
o Moved backtitle to the global variable 'dlg' so we have a single
  global variable
o Added changes from Roman Zippel to bluetitle theme
o Made bluetitle theme default
o fix of SEGV when no theme was specified

The patchset is also available at:
	git://git.kernel.org/pub/scm/linux/kernel/sam/lxdialog.git

	Sam
