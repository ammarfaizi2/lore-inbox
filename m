Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVK3F6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVK3F6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVK3F6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:58:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:29851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750763AbVK3F6p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:58:45 -0500
Cc: stern@rowland.harvard.edu
Subject: [PATCH] USB: documentation update
In-Reply-To: <20051130055607.GA4406@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 29 Nov 2005 21:58:37 -0800
Message-Id: <1133330317815@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: documentation update

This patch (as611) fixes a minor mistake and misspelling in the USB
documentation.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 620948a01c71060a32611bc2f792f58a88cf28b1
tree 69383c05e69e6241ef43d41fceb4ead4dd233c36
parent c9d6073fb3cda856132dd544d537679f9715436c
author Alan Stern <stern@rowland.harvard.edu> Mon, 28 Nov 2005 15:22:55 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 29 Nov 2005 21:39:22 -0800

 Documentation/usb/error-codes.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/usb/error-codes.txt b/Documentation/usb/error-codes.txt
index 1e36f16..867f4c3 100644
--- a/Documentation/usb/error-codes.txt
+++ b/Documentation/usb/error-codes.txt
@@ -46,8 +46,9 @@ USB-specific:
 
 -EMSGSIZE	(a) endpoint maxpacket size is zero; it is not usable
 		    in the current interface altsetting.
-		(b) ISO packet is biger than endpoint maxpacket
-		(c) requested data transfer size is invalid (negative)
+		(b) ISO packet is larger than the endpoint maxpacket.
+		(c) requested data transfer length is invalid: negative
+		    or too large for the host controller.
 
 -ENOSPC		This request would overcommit the usb bandwidth reserved
 		for periodic transfers (interrupt, isochronous).

