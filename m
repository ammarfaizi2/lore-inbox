Return-Path: <linux-kernel-owner+w=401wt.eu-S1751395AbXAVKU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbXAVKU3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbXAVKU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:20:29 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:1335 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751395AbXAVKU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:20:28 -0500
Date: Mon, 22 Jan 2007 11:20:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       "J.H." <warthog9@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [KORG] Linux history trees
Message-Id: <20070122112049.56e885d9.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Thomas, all,

It appears that kernel.org is hosting two git repositories with the
history of the linux kernel development, up to 2.6.12-rc2, which was
originally in bitkeeper. The first one is owned by Linus:
http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=summary

The second one is owned by Thomas:
http://www2.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=summary

As both trees serve the same purpose, I was thinking that we could have
a single copy. I see two benefits in doing so:
* Thomas' version is better as far as I can see (it has the author
  names which are missing from Linus' version for example) but I
  suspect most people don't know about it and use Linus' version,
  as I have been doing myself until very recently.
* It might help lower the load on the kernel.org servers (by increasing
  the cache hits.)

So I suggest that Linus deletes his old-2.6-bkcvs tree. What do you
think?

Thanks,
-- 
Jean Delvare
