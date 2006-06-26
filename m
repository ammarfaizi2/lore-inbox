Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWFZQpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWFZQpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWFZQpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:45:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20167 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750800AbWFZQpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:45:50 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/4] [Suspend2] documentation/kernel-parameters entries.
Date: Tue, 27 Jun 2006 02:45:54 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164553.10591.78903.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164547.10591.32821.stgit@nigel.suspend2.net>
References: <20060626164547.10591.32821.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the details for Suspend2 to Documentation/kernel-parameters.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 Documentation/kernel-parameters.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a9d3a17..9e91188 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -80,6 +80,7 @@ parameter is applicable:
 	SERIAL	Serial support is enabled.
 	SMP	The kernel is an SMP kernel.
 	SPARC	Sparc architecture is enabled.
+	SUSPEND2 Suspend2 is enabled.
 	SWSUSP	Software suspend is enabled.
 	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
@@ -1063,6 +1064,8 @@ running once the system is up.
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
+	noresume2	[SUSPEND2] Disables resuming and restores original swap signature.
+ 
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
@@ -1343,6 +1346,11 @@ running once the system is up.
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
+ 	resume2=	[SUSPEND2] Specify the storage device for Suspend2.
+			Format: <writer>:<writer-parameters>.
+			See Documentation/power/suspend2.txt for details of the
+			formats	for available image writers.
+
 	rhash_entries=	[KNL,NET]
 			Set number of hash buckets for route cache
 

--
Nigel Cunningham		nigel at suspend2 dot net
