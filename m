Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbTGTSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbTGTSb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 14:31:56 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24074 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S267678AbTGTSb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 14:31:56 -0400
Date: Sun, 20 Jul 2003 20:46:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Romain Lievin <roms@lpg.ticalc.org>
Cc: zippel@linux-m68k.org, curtis@maurand.com, linux-kernel@vger.kernel.org
Subject: gconfig does not save configuration
Message-ID: <20030720184648.GA2060@mars.ravnborg.org>
Mail-Followup-To: Romain Lievin <roms@lpg.ticalc.org>,
	zippel@linux-m68k.org, curtis@maurand.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain.

When playing with gconfig I noticed it failed to save the configuration if
I select "File|Quit" with the mouse.

As a bare minimum I expected a dialog box giving me the choice to save or
not.

make allnoconfig
make gconfig
- Enable networking support
- File|quit
grep CONFIG_NET .config

You will notice that CONFIG_NET is not set.

	Sam
