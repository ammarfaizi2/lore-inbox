Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVKWXrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVKWXrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKWXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:23234 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751328AbVKWXqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:31 -0500
Date: Wed, 23 Nov 2005 15:44:03 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       scjody@steamballoon.com
Subject: [patch 03/22] Clarify T: field in MAINTAINERS
Message-ID: <20051123234403.GD527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="clarify-t-field-in-maintainers.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jody McIntyre <scjody@steamballoon.com>

Pavel Machek points out that for git repos, what we include is not
actually a URL.  It is undesirable to use a URL since git repos can be
accessed in many different ways.

Signed-off-by: Jody McIntyre <scjody@steamballoon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/MAINTAINERS
+++ usb-2.6/MAINTAINERS
@@ -58,7 +58,7 @@ P: Person
 M: Mail patches to
 L: Mailing list that is relevant to this area
 W: Web-page with status/info
-T: SCM tree type and URL.  Type is one of: git, hg, quilt.
+T: SCM tree type and location.  Type is one of: git, hg, quilt.
 S: Status, one of the following:
 
 	Supported:	Someone is actually paid to look after this.

--
