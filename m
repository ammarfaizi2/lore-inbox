Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUF2Mja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUF2Mja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUF2Mja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 08:39:30 -0400
Received: from everest.2mbit.com ([24.123.221.2]:21698 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S265747AbUF2Mj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 08:39:28 -0400
Message-ID: <40E162EF.7010607@greatcn.org>
Date: Tue, 29 Jun 2004 20:39:11 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-Scan-Signature: dd674cfe4428f1d4135c3024d31be03a
X-SA-Exim-Connect-IP: 218.24.187.61
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: How about share all PFN_* ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.187.61 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

There's too many macros definitions PFN_UP PFN_DOWN PFN_PHYS PFN_ALIGN 
scattered all over.
How about a patch move them all into one header file(kernel.h or init.h)
and share only one copy of them like what min and max. I'd like to make it.


       coywolf

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

