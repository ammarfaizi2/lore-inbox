Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbTDQFyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbTDQFxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:53:20 -0400
Received: from granite.he.net ([216.218.226.66]:51984 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263076AbTDQFu4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:56 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595042845@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <1050559504205@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1061, 2003/04/14 10:25:17-07:00, david-b@pacbell.net

[PATCH] USB: DocBook/usb.tmpl patch

remove duplicated word, fix an unclear implication.


diff -Nru a/Documentation/DocBook/usb.tmpl b/Documentation/DocBook/usb.tmpl
--- a/Documentation/DocBook/usb.tmpl	Wed Apr 16 10:49:01 2003
+++ b/Documentation/DocBook/usb.tmpl	Wed Apr 16 10:49:01 2003
@@ -294,7 +294,7 @@
 	<title>The USB Filesystem (usbfs)</title>
 
 	<para>This chapter presents the Linux <emphasis>usbfs</emphasis>.
-	You may prefer to avoid avoid writing new kernel code for your
+	You may prefer to avoid writing new kernel code for your
 	USB driver; that's the problem that usbfs set out to solve.
 	User mode device drivers are usually packaged as applications
 	or libraries, and may use usbfs through some programming library
@@ -355,7 +355,9 @@
 	    configuration files.</emphasis>
 	    Stable identifiers are available, for user mode applications
 	    that want to use them.  HID and networking devices expose
-	    these IDs.
+	    these stable IDs, so that for example you can be sure that
+	    you told the right UPS to power down its second server.
+	    "usbfs" doesn't (yet) expose those IDs.
 	    </para>
 
 	</sect1>

