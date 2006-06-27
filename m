Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933430AbWF0Eqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbWF0Eqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWF0EqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:46:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:56283 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933442AbWF0Ems
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/13] [Suspend2] Remove __nosave declarations in power.h
Date: Tue, 27 Jun 2006 14:42:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044245.15066.49075.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove __nosave_begin and __nosave_end declarations in kernel/power/power.h
as they conflict with the one in include/linux/suspend2.h.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/power.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index f06f12f..19e05eb 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -35,9 +35,6 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
-/* References to section boundaries */
-extern const void __nosave_begin, __nosave_end;
-
 extern struct pbe *pagedir_nosave;
 
 /* Preferred image size in bytes (default 500 MB) */

--
Nigel Cunningham		nigel at suspend2 dot net
