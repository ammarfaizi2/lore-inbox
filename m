Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUH2Uqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUH2Uqg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUH2Um5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:42:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268304AbUH2Umb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:42:31 -0400
Message-ID: <41323FA8.80203@pobox.com>
Date: Sun, 29 Aug 2004 16:42:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@redhat.com>
Subject: interrupt cpu time accounting?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does the kernel scheduler notice when a CPU spends a lot of time doing 
interrupt processing?

For many network configurations you get the best cache affinity, etc. if 
you lock network interrupts to a single CPU.  However, on a box with 
high network load, that could mean that that CPU is spending more time 
processing interrupts than doing Real Work(tm).

Will the scheduler "notice" this, and increasingly schedule processes 
away from the interrupt-heavy CPU?

	Jeff



