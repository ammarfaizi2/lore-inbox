Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVHIOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVHIOpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVHIOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:45:05 -0400
Received: from cramus.icglink.com ([66.179.92.18]:54727 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S964793AbVHIOpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:45:04 -0400
Date: Tue, 9 Aug 2005 09:44:56 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: ziggy <ziggy@icglink.com>, Scott Holdren <scott@icglink.com>,
       Jack Massari <jack@icglink.com>
Subject: Dual 2.8ghz xeon, software raid, lvm, jfs
Message-Id: <20050809094456.3feca1ef.phil@icglink.com>
Organization: ICGLink
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 identical dual 2.8ghz xeon machines with 4gb ram, using
software raid 10 with lvm layered on top, formatted with JFS (though
at this point any filesystem with online resizing support will do). I
have the boxes stable using 2.6.10, and they pass my stress test. I was
trying to update to 2.6.12 so I can use the new ionice utility, but I'm
experiencing oopses again. Can someone take a look at my info and give
me an idea of what is causing my problems. I'm willing to test patches
if anyone cares to work with me on a fix.  All the details can be found
here:

http://www.icglink.com/cluster-debug-2.6.12.3.html

Please CC me on replies, as I am not subscribed to l-k.

Thanks for your help.

-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
