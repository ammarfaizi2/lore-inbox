Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVIBMyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVIBMyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 08:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIBMyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 08:54:41 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:37492 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030321AbVIBMyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 08:54:40 -0400
Message-ID: <43184B8A.4040801@bigpond.net.au>
Date: Fri, 02 Sep 2005 22:54:34 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: 2.6.13-mm1: hangs during boot ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Sep 2005 12:54:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... at the the point indicated by the following output:

[    8.197224] Freeing unused kernel memory: 288k freed
[    8.428217] SCSI subsystem initialized
[    8.510376] sym0: <810a> rev 0x23 at pci 0000:00:08.0 irq 11
[    8.587731] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
[    8.671531] sym0: SCSI BUS has been reset.
[    8.725530] scsi0 : sym-2.2.1
[   17.256480]  0:0:0:0: ABORT operation started.
[   22.323534]  0:0:0:0: ABORT operation timed-out.
[   22.384348]  0:0:0:0: DEVICE RESET operation started.
[   27.458702]  0:0:0:0: DEVICE RESET operation timed-out.
[   27.527544]  0:0:0:0: BUS RESET operation started.
[   32.533775]  0:0:0:0: BUS RESET operation timed-out.
[   32.599173]  0:0:0:0: HOST RESET operation started.
[   32.669659] sym0: SCSI BUS has been reset.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
