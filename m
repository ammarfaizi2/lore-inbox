Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSGQOpm>; Wed, 17 Jul 2002 10:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSGQOpm>; Wed, 17 Jul 2002 10:45:42 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:56196 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313571AbSGQOpl>; Wed, 17 Jul 2002 10:45:41 -0400
From: Philipp Thomas <philippt@t-online.de>
To: linux-kernel@vger.kernel.org
Cc: jack.bloch@icn.siemens.com
Subject: Re: No Licence on driver load
Date: Wed, 17 Jul 2002 16:48:24 +0200
Message-ID: <md0bju0ihlf2oc54osda68dlpv251tqa87@4ax.com>
References: <180577A42806D61189D30008C7E632E879399C@boca213a.boca.ssc.siemens.com>
In-Reply-To: <180577A42806D61189D30008C7E632E879399C@boca213a.boca.ssc.siemens.com>
X-Mailer: Forte Agent 1.91/32.564
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack.Bloch@icn.siemens.com [ Wed, 17 Jul 2002 09:35:29 -0400]:

>I load my own device driver into a 2.4.18-3 Kernel and get the following
>message.
>
>"Warning Loading Icdeva0s.o will taint the Kernel : No Licence"
>
>How do you stop this?

By adding a statement that states the license of your code:

MODULE_LICENSE("<license>");

to your driver. See include/linux/module.h for the possible values
<license> may have.

Philipp

-- 
Philipp Thomas                             work: pthomas@suse.de
Development SuSE Linux AG               private: philippt@t-online.de
