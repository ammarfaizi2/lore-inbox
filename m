Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161417AbWJKVYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417AbWJKVYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWJKVXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:23:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:17312 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161417AbWJKVGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:45 -0400
Date: Wed, 11 Oct 2006 14:06:13 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 32/67] Remove UML header export
Message-ID: <20061011210613.GG16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0010-Remove-UML-header-export.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

No need for UML to export headers for userspace to build against.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-um/Kbuild |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.18.orig/include/asm-um/Kbuild
+++ /dev/null
@@ -1 +0,0 @@
-include include/asm-generic/Kbuild.asm

--
