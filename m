Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWGaQJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWGaQJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGaQJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:09:14 -0400
Received: from xenotime.net ([66.160.160.81]:54434 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751237AbWGaQJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:09:13 -0400
Date: Mon, 31 Jul 2006 09:11:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Christian Kujau <evil@g-house.de>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: minor typo fixes in md.txt
Message-Id: <20060731091155.5763dcc3.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0607311300080.2482@prinz64.housecafe.de>
References: <Pine.LNX.4.64.0607311300080.2482@prinz64.housecafe.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 13:02:18 +0100 (BST) Christian Kujau wrote:

> Hi,
> 
> I stumbled over a double occurrence of the "level" file explained, so
> I took the opportunity and played Mr. Nitpick for this file. Hope you don't 
> mind...

> -- 
> BOFH excuse #230:
Attachments make review/feedback more difficult and less likely.

Anyway:

The "drop the trailing whitespace" parts are good.

However, it is common (and hence not a problem) to use
2 spaces after a period (full stop) at the end of a sentence,
so I would prefer that those parts of the patch be dropped.

-desipite possible corruption.  This is normally done with
+desipite possible corruption. This is normally done with
 despite


+        for storage of data. This will normally be the same as the
+	component_size. This can be written while assembling an
+        array. If a value less than the current component_size is

Fix indentation/alignment.


---
~Randy
