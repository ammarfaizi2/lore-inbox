Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVCIJGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVCIJGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 04:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVCIJGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 04:06:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:22150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbVCIJF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 04:05:56 -0500
Date: Wed, 9 Mar 2005 01:05:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Security contact info
Message-ID: <20050309090550.GW28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add security contact info and relevant documentation.

Signed-off-by: Chris Wright <chrisw@osdl.org>

 MAINTAINERS                |    5 +++++
 REPORTING-BUGS             |    4 ++++
 Documentation/SecurityBugs |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

===== MAINTAINERS 1.284 vs edited =====
--- 1.284/MAINTAINERS	2005-03-08 16:26:50 -08:00
+++ edited/MAINTAINERS	2005-03-09 00:28:12 -08:00
@@ -1993,6 +1993,11 @@ M:	christer@weinigel.se
 W:	http://www.weinigel.se
 S:	Supported
 
+SECURITY CONTACT
+P:	Security Officers
+M:	security@kernel.org
+S:	Supported
+
 SELINUX SECURITY MODULE
 P:	Stephen Smalley
 M:	sds@epoch.ncsc.mil
===== REPORTING-BUGS 1.2 vs edited =====
--- 1.2/REPORTING-BUGS	2002-02-04 23:39:13 -08:00
+++ edited/REPORTING-BUGS	2005-03-09 00:50:58 -08:00
@@ -16,6 +16,10 @@ code relevant to what you were doing. If
 describe how to recreate it. That is worth even more than the oops itself.
 The list of maintainers is in the MAINTAINERS file in this directory.
 
+      If it is a security bug, please copy the Security Contact listed
+in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.
+See Documentation/SecurityBugs for more infomation.
+
       If you are totally stumped as to whom to send the report, send it to
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
===== Documentation/SecurityBugs 1.0 vs 1.1 =====
--- /dev/null	2005-02-25 10:10:30 -08:00
+++ 1.1/Documentation/SecurityBugs	2005-03-09 01:01:52 -08:00
@@ -0,0 +1,38 @@
+Linux kernel developers take security very seriously.  As such, we'd
+like to know when a security bug is found so that it can be fixed and
+disclosed as quickly as possible.  Please report security bugs to the
+Linux kernel security team.
+
+1) Contact
+
+The Linux kernel security team can be contacted by email at
+<security@kernel.org>.  This is a private list of security officers
+who will help verify the bug report and develop and release a fix.
+It is possible that the security team will bring in extra help from
+area maintainers to understand and fix the security vulnerability.
+
+As it is with any bug, the more information provided the easier it
+will be to diagnose and fix.  Please review the procedure outlined in
+REPORTING-BUGS if you are unclear about what information is helpful.
+Any exploit code is very helpful and will not be released without
+consent from the reporter unless it has already been made public.
+
+2) Disclosure
+
+The goal of the Linux kernel security team is to work with the
+bug submitter to bug resolution as well as disclosure.  We prefer
+to fully disclose the bug as soon as possible.  It is reasonable to
+delay disclosure when the bug or the fix is not yet fully understood,
+the solution is not well-tested or for vendor coordination.  However, we
+expect these delays to be short, measurable in days, not weeks or months.
+A disclosure date is negotiated by the security team working with the
+bug submitter as well as vendors.  However, the kernel security team
+holds the final say when setting a disclosure date.  The timeframe for
+disclosure is from immediate (esp. if it's already publically known)
+to a few weeks.  As a basic default policy, we expect report date to
+disclosure date to be on the order of 7 days.
+
+3) Non-disclosure agreements
+
+The Linux kernel security team is not a formal body and therefore unable
+to enter any non-disclosure agreements.
