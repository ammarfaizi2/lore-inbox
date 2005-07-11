Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVGKSRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVGKSRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVGKSPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:15:40 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:59444 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261981AbVGKSNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:13:05 -0400
Message-ID: <42D2B6AD.40907@wooding.uklinux.net>
Date: Mon, 11 Jul 2005 19:13:01 +0100
From: Steven Wooding <steve@wooding.uklinux.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041227)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Real-Time Preemption Patch -RT-2.6.12-final-V0.7.51-26 failed ,to
 compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I wonder if someone can help a newbie to the Real-Time Preemption 
Patch. After appling the lastest patch (-RT-2.6.12-final-V0.7.51-26) to the 
2.6.12 vanilla kernel I get the following error when compiling the 
patched kernel:
 
arch/x86_64/kernel/mce.c: In function 'mce_read':
arch/x86_64/kernel/mce.c:383: warning: type defaults to 'int' in 
declarationd of 'DECLARE_MUTEX'
arch/x86_64/kernel/mce.c:383: warning: parameter names (without types) 
in function declaration
arch/x86_64/kernel/mce.c:392:error: 'mce_read_sem' undeclared (first 
use in this function)
 
Then the mce.o fails to get made and the make stops.
 
I've tried compiling the vanilla 2.6.12 kernel without the patch and 
that works fine. It is strange that the error should be in 
arch/x86_64/kernel/mce.c as this is not altered by the patch. I've also tried saying 
no to MCE support, but got the some error.
 
I'm using RHEL 4 on a SMP system (gcc version 3.4.3).
 
Thanks,
 
Steve.

PS Please CC me on replies. Thanks.

