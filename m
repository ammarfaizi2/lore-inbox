Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTJAJEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTJAJEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:04:33 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52643 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261351AbTJAJEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:04:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16250.39070.555465.86772@gargle.gargle.HOWL>
Date: Wed, 1 Oct 2003 11:04:30 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.6: why no EXPORT_SYMBOL of get_sb_pseudo()?
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/libfs.c:get_sb_pseudo() isn't exported to modules,
but a lot of the other stuff in fs/libfs.c is.

Is there a particular reason for this or just an oversight?

Making a private copy of get_sb_pseudo()'s definition works
in a module, but that's not exactly productive use of
programmer time or source and object code space.

/Mikael
