Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUIGMGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUIGMGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUIGMFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:05:54 -0400
Received: from main.gmane.org ([80.91.224.249]:25218 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267930AbUIGMFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:05:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: What is the maximum size in ramdisk_size boot parameter?
Date: Tue, 07 Sep 2004 21:05:39 +0900
Message-ID: <chk86k$smh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am trying to boot my laptop via PXE and I still am in the middle of nowhere...

So, while trying to cram more and more stuff on a ramdisk, I started seeing "strange behaviour" and this got me thinking, is there a limit to ramdisk_size boot parameter??

Looking at drivers/block/rd.c (on 2.6.8.1) I couldn't find anything like that...
So is there any intrinsic upper limit, apart from the total RAM size?

And what happens if I say ramdisk_size=10240 (10MB) and I load only 1MB image into it.
Will the "unused" memory be freed? i.e. is the size dynamically allocated (<docs) and the ramdisk_size is only the upper bound?

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

