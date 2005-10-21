Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVJUXOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVJUXOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVJUXOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 19:14:00 -0400
Received: from ns1.s2io.com ([142.46.200.198]:39334 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S932072AbVJUXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 19:13:59 -0400
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: <linux-kernel@vger.kernel.org>
Cc: <lse-tech@projects.sourceforge.net>, <ak@suse.de>
Subject: Question about node-specific allocation
Date: Fri, 21 Oct 2005 16:14:04 -0700
Message-ID: <MAEEKMLDLDFEGKHNIJHIMEFCCAAA.ravinandan.arakali@neterion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Spam-Score: -100.4
X-Spam-Outlook-Score: ()
X-Spam-Features: MSGID_GOOD_EXCHANGE,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In 2.6.14, I noticed that we have kmalloc_node for node-specific allocation.
But in my driver since I use dev_alloc_skb() for receive buffer allocation,
is there a node-specific version of this API ?

Thanks,
Ravi

