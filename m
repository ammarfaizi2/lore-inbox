Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbRBMKB3>; Tue, 13 Feb 2001 05:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRBMKBT>; Tue, 13 Feb 2001 05:01:19 -0500
Received: from main.braxis.co.uk ([212.160.232.26]:35081 "EHLO
	main.braxis.co.uk") by vger.kernel.org with ESMTP
	id <S129557AbRBMKBI>; Tue, 13 Feb 2001 05:01:08 -0500
Date: Tue, 13 Feb 2001 10:59:57 +0100
From: Krzysztof Rusocki <kszysiu@braxis.co.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: [?] __alloc_pages: 1-order allocation failed.
Message-ID: <20010213105957.A16713@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's what i've found today in logs:

Feb 13 02:10:41 main kernel: __alloc_pages: 1-order allocation failed. 
Feb 13 02:10:42 main last message repeated 143 times
Feb 13 02:10:47 main kernel: ed. 
Feb 13 02:10:47 main kernel: __alloc_pages: 1-order allocation failed. 
Feb 13 02:50:30 main syslogd 1.3-3: restart (remote reception).


After that there was possibly lock-up or reboot (i don't know, when i 
connected to  the machine it was already running).

What can be possible cause of such things ?

I am running 2.4.1-XFS (2001/02/10) on a Mendocino
366/128MB/VT82C596A/PDC20262.

Regards,

- Krzysztof

PS.
lkml subscribers: please reply to my email if it's possible :)
