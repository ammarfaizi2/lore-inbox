Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUCRE3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 23:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUCRE3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 23:29:10 -0500
Received: from colo.lackof.org ([198.49.126.79]:4308 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261628AbUCRE3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 23:29:07 -0500
Date: Wed, 17 Mar 2004 21:29:05 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add note about "Copyright" to SubmittingDrivers
Message-ID: <20040318042905.GA32375@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
This patch adds a comment to "Documentation/SubmittingDrivers"
about the importance of adding a Copyright notice in submitted code.

The parisc-linux port has neglected this in the past and I've
been slowly trying to correct that (along with proper GPL header).

While I make it sound like GPL is the "only" acceptable license,
I'll leave it up to lawyers to determine what other appropriate
license could be used for a new driver.

thanks,
grant

Index: Documentation/SubmittingDrivers
===================================================================
RCS file: /var/cvs/linux-2.6/Documentation/SubmittingDrivers,v
retrieving revision 1.2
diff -u -p -r1.2 SubmittingDrivers
--- a/Documentation/SubmittingDrivers	7 Jan 2004 21:29:52 -0000	1.2
+++ b/Documentation/SubmittingDrivers	18 Mar 2004 04:18:33 -0000
@@ -51,6 +51,13 @@ Licensing:	The code must be released to 
 		to be useful to other communities such as BSD you may well
 		wish to release under multiple licenses.
 
+Copyright:	The copyright owner must agree to use of GPL.
+		It's best if the submitter and copyright owner
+		are the same person/entity. If not, the name of
+		the person/entity authorizing use of GPL should be
+		listed in case it's necessary to verify the will of
+		the copright owner.
+
 Interfaces:	If your driver uses existing interfaces and behaves like
 		other drivers in the same class it will be much more likely
 		to be accepted than if it invents gratuitous new ones. 
