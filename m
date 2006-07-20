Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWGTPNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWGTPNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWGTPNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:13:38 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:57709 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932588AbWGTPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:13:37 -0400
Message-ID: <44BF9E20.1020807@oracle.com>
Date: Thu, 20 Jul 2006 08:15:44 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] Doc/SubmittingPatches cleanups
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

A few cleanups to SubmittingPatches:
- mention SubmitChecklist
- remove mention of my simple patch script tools
- remove last-updated line

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/SubmittingPatches |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- linux-2618-rc2.orig/Documentation/SubmittingPatches
+++ linux-2618-rc2/Documentation/SubmittingPatches
@@ -10,7 +10,9 @@ kernel, the process can sometimes be dau
 with "the system."  This text is a collection of suggestions which
 can greatly increase the chances of your change being accepted.
 
-If you are submitting a driver, also read Documentation/SubmittingDrivers.
+Read Documentation/SubmitChecklist for a list of items to check
+before submitting code.  If you are submitting a driver, also read
+Documentation/SubmittingDrivers.
 
 
 
@@ -74,9 +76,6 @@ There are a number of scripts which can 
 Quilt:
 http://savannah.nongnu.org/projects/quilt
 
-Randy Dunlap's patch scripts:
-http://www.xenotime.net/linux/scripts/patching-scripts-002.tar.gz
-
 Andrew Morton's patch scripts:
 http://www.zip.com.au/~akpm/linux/patches/
 Instead of these scripts, quilt is the recommended patch management
@@ -484,7 +483,7 @@ Greg Kroah-Hartman "How to piss off a ke
   <http://www.kroah.com/log/2005/10/19/>
   <http://www.kroah.com/log/2006/01/11/>
 
-NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!.
+NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <http://marc.theaimsgroup.com/?l=linux-kernel&m=112112749912944&w=2>
 
 Kernel Documentation/CodingStyle
@@ -493,4 +492,3 @@ Kernel Documentation/CodingStyle
 Linus Torvald's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
 --
-Last updated on 17 Nov 2005.



