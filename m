Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWBQX6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWBQX6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWBQX6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:58:33 -0500
Received: from secure.htb.at ([195.69.104.11]:56849 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1751804AbWBQX6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:58:32 -0500
Date: Sat, 18 Feb 2006 00:58:14 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [swsusp] not enough memory
Message-Id: <20060218005814.6548092d.delist@gmx.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FAFUR-0005bt-00*9pxY/rGlUa.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *,

On my 64MB notebook I get the following message, when going swsusp:

..
swsusp: Need to copy 15526 pages
swsusp: Not enough free memory
Error -12 suspending
..

# free
             total     used     free   shared    buffers   cached
Mem:         62760    59884     2876        0       3828    16052
-/+ buffers/cache:    40004    22756
Swap:       200804    30316   170488

If I end all apps but the XServer it works. I've allready added some
more swapspace, but that didn't help. So, how much memory will I need
for a successful suspend or better (since i can't stuff any more into 
it) is there a way to minimize the amount needed?

sl ritch
