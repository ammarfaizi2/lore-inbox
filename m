Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVAGDo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVAGDo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVAGDo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:44:27 -0500
Received: from pcsbom.patni.com ([203.124.139.208]:30821 "EHLO
	pcsspz.PATNI.COM") by vger.kernel.org with ESMTP id S261189AbVAGDoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:44:22 -0500
Reply-To: <sujeet.kumar@patni.com>
From: "Sujeet Kumar" <sujeet.kumar@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel panic after sema_init(&sem,-1) why?
Date: Fri, 7 Jan 2005 09:19:43 +0530
Message-ID: <000001c4f46b$ec8936f0$7861a8c0@pcp40702>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1105069944-6250-162"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1105069944-6250-162
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Hi !
In our sample driver ,
The system gives panic, if I initialise the semaphore  to -1
[sema_init(&sem,-1)] and
then try to acquire it by calling down() .
It gives a kernel panic . what could be the reason for this.
Where exactly is panic() called?

could not figure out easily from code.
Thanks
sujeet




http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------------=_1105069944-6250-162--
