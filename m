Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVDDQ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDDQ76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDDQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:59:58 -0400
Received: from [207.35.253.199] ([207.35.253.199]:29841 "EHLO
	smtp.discreet.com") by vger.kernel.org with ESMTP id S261285AbVDDQ7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:59:23 -0400
Subject: Assertion failure in journal_start_Rsmp_2519e07e()
From: Eric Desjardins <eric.desjardins@discreet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112633954.11836.2.camel@oshawa.rd.discreet.qc.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 04 Apr 2005 12:59:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having problem with my x86_64 workstation. I'm having about
5 kernels oops a day and usually I got that in the syslog:

Apr  4 12:45:07 oshawa kernel: Assertion failure in
journal_start_Rsmp_2519e07e() at transaction.c:249:
"handle->h_transaction->t_journal == journal"

I'm using:
Linux oshawa 2.4.21-20.ELsmp #2 SMP Wed Mar 23 18:32:06 EST 2005 x86_64
x86_64 x86_64 GNU/Linux.

Any idea where I should start to look at.

Thanks,
Eric Desjardins
