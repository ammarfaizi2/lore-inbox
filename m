Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFZU1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTFZU1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:27:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29072 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262382AbTFZU1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:27:49 -0400
Message-ID: <3EFB5A9B.3030802@redhat.com>
Date: Thu, 26 Jun 2003 16:42:03 -0400
From: Will Cohen <wcohen@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppc64 oprofile on IBM i series
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/ppc64/kernel/time.c:timer_interrupt There is the following ifndef:

#ifndef CONFIG_PPC_ISERIES
         ppc64_do_profile(regs);
#endif

I got access to a i series machine and tried a kernel with the 
surrounding ifndef removed to test whether the oprofile support would 
work on a i series machine. OProfile appears to work. Is there some 
reason that it is disabled for i series machines, e.g. doesn't work on 
particular i series machines?

-Will


