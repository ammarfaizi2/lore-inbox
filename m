Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWH3WAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWH3WAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWH3WAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:00:37 -0400
Received: from xenotime.net ([66.160.160.81]:50613 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932139AbWH3WAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:00:36 -0400
Date: Wed, 30 Aug 2006 15:03:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>,
       Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH -mm] PM: add /sys/power documentation to
 Documentation/ABI
Message-Id: <20060830150358.55233204.rdunlap@xenotime.net>
In-Reply-To: <20060830144350.3b9bb273.akpm@osdl.org>
References: <200608302338.06882.rjw@sisk.pl>
	<20060830144350.3b9bb273.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 14:43:50 -0700 Andrew Morton wrote:

> On Wed, 30 Aug 2006 23:38:06 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Documentation/ABI/testing
> 
> psst, Greg, they're still sending too much stuff: need more paperwork!
> 
> Some words about this in Documentation/SubmitChecklist would be nice.

and people actually using it would be nice(r).

Is this close to what you are looking for?
---

From: Randy Dunlap <rdunlap@xenotime.net>

Mention Documenation/ABI/ requirements in Documentation/SubmitChecklist.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/SubmitChecklist |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2618-rc5all.orig/Documentation/SubmitChecklist
+++ linux-2618-rc5all/Documentation/SubmitChecklist
@@ -61,3 +61,6 @@ kernel patches.
     Documentation/kernel-parameters.txt.
 
 18: All new module parameters are documented with MODULE_PARM_DESC()
+
+19: All new userspace interfaces are documented in Documentation/ABI/.
+    See Documentation/ABI/README for more information.
