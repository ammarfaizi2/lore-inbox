Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWJQWVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJQWVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJQWVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:21:05 -0400
Received: from mout0.freenet.de ([194.97.50.131]:50834 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1750764AbWJQWVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:21:02 -0400
Content-Disposition: inline
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] kconfig: Only activate UI save widgets when .config changed; Take 3
Date: Wed, 18 Oct 2006 00:23:04 +0200
User-Agent: KMail/1.9.4
Cc: kbuild-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200610180023.04978.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

this disables the save-widgets, as long as you haven't changed anything
yet when you are in the qt/gtk -GUI after
	"make xconfig" or "make gconfig".
There were no objections on kbuild-devel,
 though no comments neither on "Take 3".

Should apply from 2.6.19-rc1 onwards.

      Karsten

----------  Weitergeleitete Nachricht  ----------

Subject: [PATCH 0/4] kconfig: Only activate UI save widgets when .config changed; Take 3
Date: Dienstag, 10. Oktober 2006 15:33
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: kbuild-devel@lists.sourceforge.net
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>

Hi

the patchset sent following up tries to implement
functionality for *config's UIs

	to know a .config's change state.

	to accordingly
		set GUI's save-widgets sensitivity,
		remind the user to save changes.

Changes in Take 3:
	Use git-format-patch instead of cg-mkpatch.
	No code changes.

Comments welcome.

      Karsten


-------------------------------------------------------
