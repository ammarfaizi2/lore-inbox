Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWAUMLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWAUMLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWAUMLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:11:18 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:12201 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932161AbWAUMLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:11:16 -0500
Message-ID: <43D224E8.2080601@t-online.de>
Date: Sat, 21 Jan 2006 13:11:20 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: shemminger@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller 11ab:4362
 (rev 19)
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EBxwsuZQYeaADl6EewbCZl1azl2WeDi5g05+nM6qMSQO-iyRudsj8m@t-dialin.net
X-TOI-MSGID: f82ad6eb-dcd3-4b80-9188-543cfecf775b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen!

 >
 > It seems that the SuSE Firewall locked something ....
 >

The decreasing time stamp counters are not a sign of delayed printks
but of broken printk timestamping. That means that you probably see
the correct order of printks, but cpu load is increasing fast at that
point ... see my lkml mail about timer problems.

cu,
Knut

