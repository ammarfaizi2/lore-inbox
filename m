Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbUL3Xvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbUL3Xvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbUL3Xvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:51:35 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:4753 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261593AbUL3Xve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:51:34 -0500
Date: Fri, 31 Dec 2004 00:51:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: kconfig: 
Message-ID: <20041230235146.GA9450@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman & lkml

Here follows a few kconfig patches.
Main purpose is to improve readability of the output when doing  search
and to inculde dependency information in the help text.

They are not pushed to my kbuild tree yet - will see if this generate
any feedback first.

One will now see something like this when getting help on a menu item:

CONFIG_FOO
bla bla bla

depends on:
 USB
selects:
 HOTPLUG
selected by:
 FW_LOADER


Empty lines are omitted - so a symbol that does not seletcs any other
symbol the symbol line will not appear.

Let me know if you want me to push them towards mainstream.

	Sam
