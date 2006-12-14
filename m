Return-Path: <linux-kernel-owner+w=401wt.eu-S1751903AbWLNIF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbWLNIF4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWLNIF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:05:56 -0500
Received: from mga05.intel.com ([192.55.52.89]:42721 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751903AbWLNIFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:05:55 -0500
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 03:05:55 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,166,1165219200"; 
   d="scan'208"; a="177287638:sNHT20786941"
Message-ID: <45810383.2060708@linux.intel.com>
Date: Thu, 14 Dec 2006 08:55:47 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible
 to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>	<m1lklbport.fsf@ebiederm.dsl.xmission.com>	<20061213194332.GA29185@elte.hu>	<m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>	<45806137.4020403@linux.intel.com> <m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> What is the problem you are trying to solve?

2 problems
1) irq's that irqbalance should not touch at all
2) irqs that can only go to a subset of processors.

1) is very real today
2) is partially real on some of the bigger numa stuff already.
