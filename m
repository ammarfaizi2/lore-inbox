Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTKMBQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 20:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTKMBQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 20:16:18 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:24519 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261831AbTKMBQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 20:16:17 -0500
Message-ID: <3FB2DA30.4090406@upb.de>
Date: Thu, 13 Nov 2003 02:11:12 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: de, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] modprobe sch_htb fails
References: <bld5lc$p3n$1@sea.gmane.org> <20031112165031.GA5962@fs.tum.de>
In-Reply-To: <20031112165031.GA5962@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.upb.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=3.271,
	required 4, IDENT_NOBODY 0.00, RCVD_IN_DYNABLOCK 2.55,
	RCVD_IN_NJABL 0.10, RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-UNI-PB_FAK-EIM-MailScanner-SpamScore: sss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>"modprobe sch_htb" failed with:
>>
>>/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
>>qdisc_get_rtab
>>...
> 
> Does this problem still occur in 2.4.23-rc1?

I again compiled everything unter Networking/QoS as a module and it 
works now. I think the problem is gone now.

Thx for fixing it.

cu
Sven

