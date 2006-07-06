Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWGFNHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWGFNHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGFNHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:07:54 -0400
Received: from canuck.infradead.org ([205.233.218.70]:8684 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030254AbWGFNHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:07:53 -0400
Subject: [GIT *] Remove inclusion of obsolete <linux/config.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:07:45 +0100
Message-Id: <1152191265.2987.154.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from git://git.infradead.org/~dwmw2/killconfig.h.git

This contains two commits. The first removes all inclusions of
<linux/config.h> from the kernel sources, and the second turns
include/linux/config.h into a one-line #error.

I chose to add #error rather than just deleting the file, to make the
error message more informative and hopefully prevent too many people
from asking "where did config.h go?".

Sam thinks it should be a #warning instead, even though it's been
unnecessary to include config.h for about eight months now. If you
agree, pull from git://git.infradead.org/~dwmw2/woundconfig.h.git
instead -- that contains the same first commit and then the second
commit creates a #warning instead.

Please pull one or the other.

-- 
dwmw2

