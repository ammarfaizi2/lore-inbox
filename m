Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWCUNs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWCUNs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWCUNsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:48:25 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:8622 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030374AbWCUNsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:48:24 -0500
Message-ID: <44200223.4020404@t-online.de>
Date: Tue, 21 Mar 2006 14:39:47 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [BUG] compiler warning, kernel 2.6.16
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: X7-U88ZOZe+sO0psPtyoR0gbMitChVOkpZLFzgl6FafMpoGfOI5UsJ@t-dialin.net
X-TOI-MSGID: 46c233a0-6e68-4df6-991e-021d3ef65a1a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SWAP is _not_ set, gcc complains:

/src/linux-2.6.16-tfix/mm/vmscan.c: In function `remove_mapping':
/src/linux-2.6.16-tfix/mm/vmscan.c:398: warning: unused variable `swap'

cu,
 knut
