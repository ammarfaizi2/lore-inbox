Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVDBVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVDBVsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDBVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:38:32 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:40372 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261400AbVDBV21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:28:27 -0500
X-Qmail-Scanner-Toxic-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Toxic-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner-Toxic: 1.24st (Clear:RC:1(213.238.99.87):. Processed in 0.040569 secs Process 23454)
Date: Sat, 2 Apr 2005 23:30:07 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <74334709.20050402233007@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [2.6.12-rc1-mm4] swapped memset arguments
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

out of boredom I grepped 2.6.12-rc1-mm4 for swapped memset arguments.
I found one:

# grep -nr "memset.*\,\(\ \|\)0\(\ \|\));" *
net/ieee80211/ieee80211_tx.c:226:       memset(txb, sizeof(struct ieee80211_txb), 0);  

I found none in Linus' bk.

Regards,
Maciej


