Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVEDRCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVEDRCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVEDRCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:02:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52469 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261909AbVEDRB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:01:59 -0400
Subject: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 04 May 2005 10:01:56 -0700
Message-Id: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the general opinion of posting patches as attachments
has changed over the last few years.  Mailers have been getting
a lot better at handling them, even quoting non-message-body
plain/text attachments in replies.  

Plus, a plain/text attachment message saved to a file can go
into 'patch' the same way that an inline one can.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/Documentation/SubmittingPatches |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -L Documentation/Submitting -puN /dev/null /dev/null
diff -puN Documentation/SubmittingPatches~submitting-patches Documentation/SubmittingPatches
--- memhotplug/Documentation/SubmittingPatches~submitting-patches	2005-05-04 08:07:25.000000000 -0700
+++ memhotplug-dave/Documentation/SubmittingPatches	2005-05-04 09:11:27.000000000 -0700
@@ -181,17 +181,24 @@ patches. Trivial patches must qualify fo
 
 
 
-6) No MIME, no links, no compression, no attachments.  Just plain text.
+6) No MIME, no links, no compression.  Just plain text.
 
 Linus and other kernel developers need to be able to read and comment
 on the changes you are submitting.  It is important for a kernel
 developer to be able to "quote" your changes, using standard e-mail
 tools, so that they may comment on specific portions of your code.
 
-For this reason, all patches should be submitting e-mail "inline".
+For this reason, the preferred way of submitting patches in e-mail is
+"inline", in the same part of the message with everything else.
 WARNING:  Be wary of your editor's word-wrap corrupting your patch,
 if you choose to cut-n-paste your patch.
 
+Many maintainers will now accept patches submitted to them as
+text/plain attachments.  Many mailers quote these attachements in the
+same way that they do for inline patches.  But, some maintainers still
+prefer inlines and they are certainly the safest bet.  In any case,
+never attach more than one patch to a single e-mail.
+
 Do not attach the patch as a MIME attachment, compressed or not.
 Many popular e-mail applications will not always transmit a MIME
 attachment as plain text, making it impossible to comment on your
_
