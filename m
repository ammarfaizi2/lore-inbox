Return-Path: <linux-kernel-owner+w=401wt.eu-S1750701AbWLMUX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWLMUX0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLMUX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:23:26 -0500
Received: from mga07.intel.com ([143.182.124.22]:48629 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750701AbWLMUX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:23:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="157855397:sNHT20256950"
Message-ID: <45806137.4020403@linux.intel.com>
Date: Wed, 13 Dec 2006 21:23:19 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible
 to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>	<m1lklbport.fsf@ebiederm.dsl.xmission.com>	<20061213194332.GA29185@elte.hu> <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> There is still a question of how to handle the NUMA case but...
>

the numa case is already handled; the needed info for that is exposed 
already enough... at least for irqbalance
