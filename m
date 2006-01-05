Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752157AbWAETQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbWAETQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWAETQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:16:55 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:57255 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752157AbWAETQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:16:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=G5wrkwcko88mlbKQF1SJxIhi9TDsrR5JpXtY+GyLa69gFgQHAathrYlUIGoLF3xWQyvxUDMH68PJA6AebI287WYi/dED11CsoWifLCdUzmvPznkh6/UAXQiqeaBrjaDQYxoLm5rTJXzYyvkAqflnXxwFR/w9Y9LtvB84hhadyYc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] Docs update: small fixes to stable_kernel_rules.txt
Date: Thu, 5 Jan 2006 20:16:45 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601052016.45135.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Small spelling, formating & similar fixes to stable_kernel_rules.txt

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/stable_kernel_rules.txt |   60 ++++++++++++++++------------------
 1 files changed, 29 insertions(+), 31 deletions(-)

--- linux-2.6.15-mm1-orig/Documentation/stable_kernel_rules.txt	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-mm1/Documentation/stable_kernel_rules.txt	2006-01-05 18:36:22.000000000 +0100
@@ -1,58 +1,56 @@
 Everything you ever wanted to know about Linux 2.6 -stable releases.
 
-Rules on what kind of patches are accepted, and what ones are not, into
-the "-stable" tree:
+Rules on what kind of patches are accepted, and which ones are not, into the
+"-stable" tree:
 
  - It must be obviously correct and tested.
- - It can not bigger than 100 lines, with context.
+ - It can not be bigger than 100 lines, with context.
  - It must fix only one thing.
  - It must fix a real bug that bothers people (not a, "This could be a
-   problem..." type thing.)
+   problem..." type thing).
  - It must fix a problem that causes a build error (but not for things
    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
-   security issue, or some "oh, that's not good" issue.  In short,
-   something critical.
- - No "theoretical race condition" issues, unless an explanation of how
-   the race can be exploited.
+   security issue, or some "oh, that's not good" issue.  In short, something
+   critical.
+ - No "theoretical race condition" issues, unless an explanation of how the
+   race can be exploited is also provided.
  - It can not contain any "trivial" fixes in it (spelling changes,
-   whitespace cleanups, etc.)
+   whitespace cleanups, etc).
  - It must be accepted by the relevant subsystem maintainer.
- - It must follow Documentation/SubmittingPatches rules.
+ - It must follow the Documentation/SubmittingPatches rules.
 
 
 Procedure for submitting patches to the -stable tree:
 
  - Send the patch, after verifying that it follows the above rules, to
    stable@kernel.org.
- - The sender will receive an ack when the patch has been accepted into
-   the queue, or a nak if the patch is rejected.  This response might
-   take a few days, according to the developer's schedules.
- - If accepted, the patch will be added to the -stable queue, for review
-   by other developers.
+ - The sender will receive an ACK when the patch has been accepted into the
+   queue, or a NAK if the patch is rejected.  This response might take a few
+   days, according to the developer's schedules.
+ - If accepted, the patch will be added to the -stable queue, for review by
+   other developers.
  - Security patches should not be sent to this alias, but instead to the
-   documented security@kernel.org.
+   documented security@kernel.org address.
 
 
 Review cycle:
 
- - When the -stable maintainers decide for a review cycle, the patches
-   will be sent to the review committee, and the maintainer of the
-   affected area of the patch (unless the submitter is the maintainer of
-   the area) and CC: to the linux-kernel mailing list.
- - The review committee has 48 hours in which to ack or nak the patch.
+ - When the -stable maintainers decide for a review cycle, the patches will be
+   sent to the review committee, and the maintainer of the affected area of
+   the patch (unless the submitter is the maintainer of the area) and CC: to
+   the linux-kernel mailing list.
+ - The review committee has 48 hours in which to ACK or NAK the patch.
  - If the patch is rejected by a member of the committee, or linux-kernel
-   members object to the patch, bringing up issues that the maintainers
-   and members did not realize, the patch will be dropped from the
-   queue.
- - At the end of the review cycle, the acked patches will be added to
-   the latest -stable release, and a new -stable release will happen.
- - Security patches will be accepted into the -stable tree directly from
-   the security kernel team, and not go through the normal review cycle.
+   members object to the patch, bringing up issues that the maintainers and
+   members did not realize, the patch will be dropped from the queue.
+ - At the end of the review cycle, the ACKed patches will be added to the
+   latest -stable release, and a new -stable release will happen.
+ - Security patches will be accepted into the -stable tree directly from the
+   security kernel team, and not go through the normal review cycle.
    Contact the kernel security team for more details on this procedure.
 
 
 Review committe:
 
- - This will be made up of a number of kernel developers who have
-   volunteered for this task, and a few that haven't.
-
+ - This is made up of a number of kernel developers who have volunteered for
+   this task, and a few that haven't.



