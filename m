Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWGXLhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWGXLhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWGXLhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:37:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:60849 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932118AbWGXLhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:37:11 -0400
Date: Mon, 24 Jul 2006 13:36:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [PATCH 0/3] kconfig/lxdialog: color theme support
Message-ID: <20060724113641.GA22806@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following three patches introduce support for color themes in
menuconfig.
First patch is a refactoring of the color support in lxdialog, and the
next two introduces two new color schemes: blackbg and bluetitle.

The latter should be well know to -mm users.

To use a color theme:

make MENUCONFIG_COLOR=blackbg menuconfig

Avalable themes:
blackbg, mono, bluetitle

	Sam
