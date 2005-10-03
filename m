Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbVJCTj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVJCTj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVJCTj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:39:59 -0400
Received: from cpe-70-112-173-183.austin.res.rr.com ([70.112.173.183]:22246
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932658AbVJCTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:39:58 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: minor documentation revisions
Cc: v9fs-developer@lists.sourceforge.net
Message-Id: <20051003193953.7D5DA48B5@localhost.localdomain>
Date: Mon,  3 Oct 2005 14:39:53 -0500 (CDT)
From: ericvh@ericvh.myip.org (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: minor documentation revisions

A few minor documentation revisions:
  a) change debug documentation to use decimal instead of hexdecimal
     debug codes (to match current code)
  b) remove timeout option (which was removed from the code)
  c) change bug-reporting method from sourceforge to bugzilla

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit ae0cee5ba09de6bbfcde6cf8a48e281b544a7d34
tree 7ffaf19d60455fabb0e06bb5cb017db857fc620e
parent eae57357841b0c6d3000e6de66195aa848ee93c9
author Eric Van Hensbergen <ericvh@gmail.com> Mon, 03 Oct 2005 14:35:55 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Mon, 03 Oct 2005 14:35:55 -0500

 Documentation/filesystems/v9fs.txt |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/v9fs.txt b/Documentation/filesystems/v9fs.txt
--- a/Documentation/filesystems/v9fs.txt
+++ b/Documentation/filesystems/v9fs.txt
@@ -40,14 +40,14 @@ OPTIONS
   		offering several exported file systems.
 
   debug=n	specifies debug level.  The debug level is a bitmask.
-  			0x01 = display verbose error messages
-			0x02 = developer debug (DEBUG_CURRENT)
-			0x04 = display 9P trace
-			0x08 = display VFS trace
-			0x10 = display Marshalling debug
-			0x20 = display RPC debug
-			0x40 = display transport debug
-			0x80 = display allocation debug
+  			1   = display verbose error messages
+			2   = developer debug (DEBUG_CURRENT)
+			4   = display 9P trace
+			8   = display VFS trace
+			16  = display Marshalling debug
+			32  = display RPC debug
+			64  = display transport debug
+			128 = display allocation debug
 
   rfdno=n	the file descriptor for reading with proto=fd
 
@@ -57,8 +57,6 @@ OPTIONS
 
   port=n	port to connect to on the remote server
 
-  timeout=n	request timeouts (in ms) (default 60000ms)
-
   noextend	force legacy mode (no 9P2000.u semantics)
 
   uid		attempt to mount as a particular uid
@@ -75,8 +73,7 @@ RESOURCES
 =========
 
 The Linux version of the 9P server, along with some client-side utilities
-can be found at http://v9fs.sf.net (along with a CVS repository of the
-development branch of this module).  There are user and developer mailing
+can be found at http://v9fs.sf.net.  There are user and developer mailing
 lists here, as well as a bug-tracker.
 
 For more information on the Plan 9 Operating System check out
@@ -91,5 +88,6 @@ STATUS
 
 The 2.6 kernel support is working on PPC and x86.
 
-PLEASE USE THE SOURCEFORGE BUG-TRACKER TO REPORT PROBLEMS.
+PLEASE USE THE KERNEL BUGZILLA TO REPORT PROBLEMS. (http://bugzilla.kernel.org)
+
 
