Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424059AbWLBOAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424059AbWLBOAH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 09:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163012AbWLBOAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 09:00:07 -0500
Received: from neopsis.com ([213.239.204.14]:43397 "EHLO
	matterhorn.dbservice.com") by vger.kernel.org with ESMTP
	id S1163009AbWLBOAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 09:00:06 -0500
Message-ID: <45718AE9.8060202@dbservice.com>
Date: Sat, 02 Dec 2006 14:17:13 +0000
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Thunderbird 2.0a1 (X11/20061109)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.19: skb_over_panic, followed by a BUG at net/core/skbuff.c:93
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Neopsis MailScanner using ClamAV and Spaassassin
X-Neopsis-MailScanner: Found to be clean
X-Neopsis-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.389,
	required 5, autolearn=spam, AWL 0.21, BAYES_00 -2.60)
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I only have a screenshot with no backtrace, if you want to see the
function names in the backtrace, please tell me what I need to do.

http://dbservice.com/ftpdir/tom/kernel-bug.jpg

I was running a 2.6.19-ge??? kernel before (I don't remember which
version exactly) and it was running fine, today I upgraded to v2.6.19
and now I have this crash. 2.6.18 works fine, too.

The bug happens when gentoo wants to bring up eth0 (starting the lo
device works fine), even a simple 'ifconfig eth0 192.168.0.11' will
crash the kernel.

The computer is a Shuttle XPC with an AMD 64bit CPU, network card is
integrated in the nforce chipset.

tom
