Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751750AbWANHR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWANHR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWANHR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:17:56 -0500
Received: from xenotime.net ([66.160.160.81]:40375 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751748AbWANHR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:17:56 -0500
Date: Fri, 13 Jan 2006 23:17:53 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jens Axboe <axboe@suse.de>, akpm <akpm@osdl.org>
Cc: ram.gupta5@gmail.com, tshxiayu@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: something about disk fragmentation
Message-Id: <20060113231753.34d58e1f.rdunlap@xenotime.net>
In-Reply-To: <20060113192452.GY3945@suse.de>
References: <7cd5d4b40601110501w40bc28f0peb13cdbb082e2b4a@mail.gmail.com>
	<728201270601110633i2eb8c71dq8a0c23d9e7ad724f@mail.gmail.com>
	<7cd5d4b40601130158l274a3b19t13f2a58a28cc3819@mail.gmail.com>
	<728201270601130814k37c31f7bxd04a1fe44213b430@mail.gmail.com>
	<20060113192452.GY3945@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Update kernel-parameters.txt IOSCHED to spell out 'anticipatory'.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2615-g9.orig/Documentation/kernel-parameters.txt
+++ linux-2615-g9/Documentation/kernel-parameters.txt
@@ -471,7 +471,7 @@ running once the system is up.
 			arch/i386/kernel/cpu/cpufreq/elanfreq.c.
 
 	elevator=	[IOSCHED]
-			Format: {"as" | "cfq" | "deadline" | "noop"}
+			Format: {"anticipatory" | "cfq" | "deadline" | "noop"}
 			See Documentation/block/as-iosched.txt and
 			Documentation/block/deadline-iosched.txt for details.
 


---
