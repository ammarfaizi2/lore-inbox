Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVJEUhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVJEUhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVJEUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:37:10 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:63707 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbVJEUhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:37:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qmAiVYtircGxdmW8xYbyFnZwYOIrk0AFgXoBMhW2v7t2iKQ/X+z0Kb4XvXDEyRrmutBikK0NrXx0Ue9qzTvY43jgJnIxNVgRgLvApWFjd3FWLxR1r/ageG450KbejJY1cY5/F0qvF/C6ZE17K6poEuxQZCrndrOnpdui+7zAIkM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: ksymoops should no longer be used to decode Oops messages
Date: Wed, 5 Oct 2005 22:39:43 +0200
User-Agent: KMail/1.8.2
Cc: Chris Ricker <kaboom@gatech.edu>, chris.ricker@genetics.utah.edu,
       Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510052239.43492.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document the fact that ksymoops should no longer be used to decode Oops
messages.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/Changes |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc3-git5-orig/Documentation/Changes	2005-10-03 21:54:50.000000000 +0200
+++ linux-2.6.14-rc3-git5/Documentation/Changes	2005-10-05 22:35:44.000000000 +0200
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: October 29th, 2002
+Last updated: October 05th, 2005
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -139,9 +139,8 @@
 Ksymoops
 --------
 
-If the unthinkable happens and your kernel oopses, you'll need a 2.4
-version of ksymoops to decode the report; see REPORTING-BUGS in the
-root of the Linux source for more information.
+With a 2.4 kernel you need ksymoops to decode a kernel Oops message. With
+2.6 kernels ksymoops is no longer needed and should not be used.
 
 Module-Init-Tools
 -----------------
