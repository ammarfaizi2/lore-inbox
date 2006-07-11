Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWGKP3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGKP3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGKP3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:29:08 -0400
Received: from canuck.infradead.org ([205.233.218.70]:60397 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751279AbWGKP3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:29:07 -0400
Subject: [GIT *] Remove inclusion of obsolete <linux/config.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Jul 2006 16:28:49 +0100
Message-Id: <1152631729.3373.197.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from git://git.infradead.org/~dwmw2/killconfig.h.git

This removes all inclusion of the obsolete <linux/config.h> and turns
that file into a simple #error. I chose to add #error rather than just
deleting the file, to make the error message more informative and
hopefully prevent too many people from asking "where did config.h go?".

Sam thinks it should be a #warning instead, even though it's been
unnecessary to include config.h for about eight months now. If you
agree, pull from git://git.infradead.org/~dwmw2/woundconfig.h.git
instead -- that differs from the first in that it turns config.h into a
#warning instead.

Please pull one or the other, as you see fit.

-- 
dwmw2

