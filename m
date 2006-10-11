Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161404AbWJKVIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbWJKVIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161420AbWJKVIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:19872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161404AbWJKVGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:47 -0400
Date: Wed, 11 Oct 2006 14:06:10 -0700
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
Subject: [patch 31/67] Remove ARM26 header export.
Message-ID: <20061011210610.GF16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0009-Remove-ARM26-header-export.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

We ought to be able to use ARM headers; no need for special ARM26 version.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-arm26/Kbuild |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.18.orig/include/asm-arm26/Kbuild
+++ /dev/null
@@ -1 +0,0 @@
-include include/asm-generic/Kbuild.asm

--
