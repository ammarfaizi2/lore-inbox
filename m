Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWHCCER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWHCCER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHCCER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:04:17 -0400
Received: from msr49.hinet.net ([168.95.4.149]:27847 "EHLO msr49.hinet.net")
	by vger.kernel.org with ESMTP id S1751290AbWHCCEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:04:16 -0400
Message-ID: <024c01c6b6a0$fcf783e0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <akpm@osdl.org>, "Francois Romieu" <romieu@fr.zoreil.com>
References: <1154030065.5967.15.camel@localhost.localdomain> <20060727125421.GB22935@tuxdriver.com> <044901c6b1ec$d0f5b680$4964a8c0@icplus.com.tw> <44C9E369.7070703@pobox.com>
Subject: Re: [PATCH] Create IP100A Driver
Date: Thu, 3 Aug 2006 10:03:17 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jeff:

    I had discuss with our peoples. We decided to use sundance.c to support
IP100A. We will also update some bug fix to this driver.

Thanks for your suggestion.

Best Regards,
Jesse Huang

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: "John W. Linville" <linville@tuxdriver.com>;
<linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>; <akpm@osdl.org>
Sent: Friday, July 28, 2006 6:14 PM
Subject: Re: [PATCH] Create IP100A Driver

Although it is occasionally OK to duplicate a driver, I do not see a
compelling case with ip100a.

The stronger case for a single codebase is won on the strengths of lower
long-term maintenance costs, increased strength of review, doesn't break
existing sundance driver uses, and re-use of existing testing benefits.

If you feel strongly about not showing "sundance" to your users, you can
always submit a one-line MODULE_ALIAS() change which permits users to
load "ip100a" (really sundance.c).  Using MODULE_ALIAS() seems quite
reasonable, given that IC Plus appears to be taking the lead in future
Sundance-like chip development.

So, please resubmit as changes to the existing sundance.c.  This is
better for the standard Linux kernel engineering process.

Thanks,

Jeff


