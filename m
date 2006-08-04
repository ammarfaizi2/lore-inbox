Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWHDFrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWHDFrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWHDFpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:45:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33968 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030347AbWHDFpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:45:36 -0400
Date: Thu, 3 Aug 2006 22:40:53 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/23] Add stable branch to maintainers file
Message-ID: <20060804054053.GW769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-stable-branch-to-maintainers-file.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Steven Rostedt <rostedt@goodmis.org>

While helping someone to submit a patch to the stable branch, I noticed
that the stable branch is not listed in the MAINTAINERS file.  This was
after I went there to look for the email addresses for the stable branch
list (stable@kernel.org).

This patch adds the stable branch to the maintainers file so that people
can find where to send patches when they have a fix for the stable team.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.17.7.orig/MAINTAINERS
+++ linux-2.6.17.7/MAINTAINERS
@@ -2572,6 +2572,14 @@ M:	dbrownell@users.sourceforge.net
 L:	spi-devel-general@lists.sourceforge.net
 S:	Maintained
 
+STABLE BRANCH:
+P:	Greg Kroah-Hartman
+M:	greg@kroah.com
+P:	Chris Wright
+M:	chrisw@sous-sol.org
+L:	stable@kernel.org
+S:	Maintained
+
 TPM DEVICE DRIVER
 P:	Kylene Hall
 M:	kjhall@us.ibm.com

--
